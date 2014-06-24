//
//  AlertViewHelper.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/22/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "AlertViewHelper.h"
#import "BonusController.h"
#import "Constants.h"

static AlertViewHelper *_shared = NULL;
@implementation AlertViewHelper

+(AlertViewHelper*)sharedInstance
{
    if (_shared == NULL)
    {
        _shared = [[AlertViewHelper alloc] init];
    }
    
    return _shared;
}
-(void)showAlertView: (NSString*)Message title:(NSString*)title cancelButton:(NSString*)cancelButton otherButton:(NSString*)otherButton view:(CCNode*)node positionX:(int)positionX positionY:(int)positionY fontName:(NSString*)fontName fontSize:(int)fontSize selector:(SEL)actionSelector zOrder:(int)zOrder{
    if(![node getChildByName:@"alert" recursively:YES]) {
        _tempNode = node;
        
        _body = [CCSprite spriteWithImageNamed:@"alertbody.png"];
        _body.position = ccp(positionX, positionY);
        _body.zOrder = zOrder;
        _body.scale = 0;
        
        [node addChild:_body z:zOrder name:@"alert"];
        
        
        CCLabelTTF* titleString = [CCLabelTTF labelWithString:title fontName:fontName fontSize:39];
        titleString.position = ccp(_body.contentSize.width / 2+15, _body.contentSize.height / 1.3);
        [_body addChild:titleString];
        
        CCLabelTTF* messageString = [CCLabelTTF labelWithString:Message fontName:fontName fontSize:fontSize];
        messageString.position = ccp(_body.contentSize.width / 2+15, _body.contentSize.height / 2);
        messageString.horizontalAlignment = CCTextAlignmentCenter;
        [_body addChild:messageString];
        
        cancel = [CCButton buttonWithTitle:cancelButton fontName:fontName fontSize:30];
        [cancel setTarget:self selector:@selector(cancelAction)];
        if(otherButton == nil) {
            cancel.position = ccp(_body.contentSize.width / 2+15, _body.contentSize.height / 4);
        }
        else {
            cancel.position = ccp(_body.contentSize.width / 2.5, _body.contentSize.height / 4);
        }
        [_body addChild:cancel];
        
        CCButton* other = [CCButton buttonWithTitle:otherButton fontName:fontName fontSize:30];
        other.position = ccp(_body.contentSize.width / 1.5, _body.contentSize.height / 4);
        if(actionSelector !=nil) {
            [other setTarget:node selector:actionSelector];
        }
        [_body addChild:other];
        
        id action = [CCActionSequence actions:
                     [CCActionScaleTo actionWithDuration:.1 scale:1.0f],
                     [CCActionScaleTo actionWithDuration:.1 scale:0.7f],
                     [CCActionScaleTo actionWithDuration:.1 scale:1.0f],
                     nil];
        [_body runAction:action];
        [_tempNode setUserInteractionEnabled:NO];
    }
    
}
-(void)cancelAction {
    [_tempNode setUserInteractionEnabled:YES];
    cancel.enabled = NO;
    isAlertViewVisible = NO;
    id action = [CCActionSequence actions:
                 [CCActionScaleTo actionWithDuration:.1 scale:1.3f],
                 [CCActionScaleTo actionWithDuration:.1 scale:0.0f],
                 nil];
    [_body runAction:action];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_tempNode removeChild:_body];
        cancel.enabled = YES;
    });
    
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"videoAd"] == YES) {

        
        [[CCDirector sharedDirector]replaceScene:[BonusController scene]];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"videoAd"];
        
    }
    
}
@end
