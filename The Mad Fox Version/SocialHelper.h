//
//  SocialHelper.h
//  Avoider
//
//  Created by Viktor Todorov on 4/4/14.
//  Copyright (c) 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface SocialHelper : NSObject <MFMailComposeViewControllerDelegate> {
    
}
- (void)ShowTwitter: (float) yourScore viewControoler:(UIViewController*)controller;
- (void)ShowFacebook: (float) yourScore viewControoler:(UIViewController*)controller;
- (void)ShowMail: (float) yourScore viewControoler:(UIViewController*)controller;
+ (SocialHelper*)sharedInstance;
@end
