//
//  SocialHelper.m
//  Avoider
//
//  Created by Viktor Todorov on 4/4/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import "SocialHelper.h"
#import "Reachability.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "UserDefaultsUtils.h"
#import "BonusController.h"
#import "AlertViewHelper.h"

static SocialHelper *_shared = NULL;

@implementation SocialHelper

+(SocialHelper*)sharedInstance
{
    if (_shared == NULL)
    {
        _shared = [[SocialHelper alloc] init];
    }
    
    return _shared;
}

- (void)ShowTwitter: (float) yourScore viewControoler:(UIViewController*)controller {
    
    NSLog(@"Starting Twitter.....");
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
       
        NSLog(@"There IS NO internet connection");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"No internet connection. Please try again later!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    } else {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            NSString *_myTweetMsg = @"I am playing Mad Fox. Check it out in app store1";

            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:_myTweetMsg];
            //[self.view.window.rootViewController  presentViewController:tweetSheet animated:YES completion:nil]; - for SpriteKit & Cocos2d
            
            [controller presentViewController:tweetSheet animated:YES completion:nil];
            
            tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
                switch(result) {
                        //  This means the user cancelled without sending the Tweet
                    case SLComposeViewControllerResultCancelled:
                        break;
                        //  This means the user hit 'Send'
                    case SLComposeViewControllerResultDone:
                        NSLog(@"Sent");
                        UIAlertView *alertView = [[UIAlertView alloc]
                                                  initWithTitle:@"Thank You"
                                                  message:@"You successfully received 10 Hint Points"
                                                  delegate:self
                                                  cancelButtonTitle:@"Sweet"
                                                  otherButtonTitles:nil];
                        [alertView show];

                        [[UserDefaultsUtils sharedInstance]setBonusApproved:YES BonusNumber:1];
                        [[UserDefaultsUtils sharedInstance]addMoney:150];
                        [[CCDirector sharedDirector]replaceScene:[BonusController scene]];
                        break;
                }
            };
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}
- (void)ShowFacebook: (float) yourScore viewControoler:(UIViewController*)controller{
    NSLog(@"Starting Facebook..... ");
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"No internet connection. Please try again later!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    } else {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controllera = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            NSString *_myFacebookMsg = @"I am playing Mad Fox. Check it out in app store: ";
            
            [controllera setInitialText:_myFacebookMsg];
            [controllera addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bubble-math/id874794787?ls=1&mt=8"]];
            [controllera addImage:[UIImage imageNamed:@"icon_60x60.png"]];
            
            //[self.view.window.rootViewController  presentViewController:controller animated:YES completion:nil]; - for SpriteKit & Cocos2d
            [controller presentViewController:controllera animated:YES completion:nil];
            
            controllera.completionHandler = ^(SLComposeViewControllerResult result) {
                switch(result) {
                        //  This means the user cancelled without sending the Tweet
                    case SLComposeViewControllerResultCancelled:
                        break;
                        //  This means the user hit 'Send'
                    case SLComposeViewControllerResultDone:
                        NSLog(@"Sent");
                        [[UserDefaultsUtils sharedInstance]setBonusApproved:YES BonusNumber:3];
                        [[UserDefaultsUtils sharedInstance]addMoney:150];
                        [[CCDirector sharedDirector]replaceScene:[BonusController scene]];
                        break;
                }
            };

        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't share to Facebook right now, make sure you have set up at least 1 Facebook Account from Settigns!"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }
    }
}
- (void)ShowMail: (float) yourScore viewControoler:(UIViewController*)controller{

    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"No internet connection. Please try again later!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    } else {
        if (![MFMailComposeViewController canSendMail]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Email cannot be configure." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        // Email Subject
        NSString *emailTitle = @"I rock on Bubble Math";
        // Email Content
        NSString *score;
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"GameMode"] isEqualToString:@"arcade"]) {
            score = [NSString stringWithFormat:@"I calculate: %0.0f Bubbles in Arcade Mode. Can you beat it?.",yourScore];
        }
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"GameMode"] isEqualToString:@"classic"]) {
            score = [NSString stringWithFormat:@"I calculate 15 bubbles in %.2f seconds. Are you faster?.",yourScore];
        }
        else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"GameMode"] isEqualToString:@"40"]){
            score = [NSString stringWithFormat:@"I calculate: %0.0f Bubbles in 40 seconds. Can you beat it?.",yourScore];
        }
        else {
            NSLog(@"The mode is nil");
        }
        NSString *messageBody = score;
        // To address
        NSArray *toRecipents = [NSArray arrayWithObject:@"EMAIL TO?"];
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        //[mc addAttachmentData:UIImageJPEGRepresentation(myImage, 1) mimeType:@"image/jpeg" fileName:@"MyFile.jpeg"];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        //[self.view.window.rootViewController  presentViewController:mc animated:YES completion:nil]; - for SpriteKit & Cocos2d
        [controller presentViewController:mc animated:YES completion:nil];
    }
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
