//
//  AlertViewHelper.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/22/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface AlertViewHelper : NSObject {
    CCSprite* _body;
    CCNode* _tempNode;
    CCButton* cancel;
}
+ (AlertViewHelper*)sharedInstance;
-(void)showAlertView: (NSString*)Message title:(NSString*)title cancelButton:(NSString*)cancelButton otherButton:(NSString*)otherButton view:(CCNode*)node positionX:(int)positionX positionY:(int)positionY fontName:(NSString*)fontName fontSize:(int)fontSize selector:(SEL)actionSelector zOrder:(int)zOrder;
-(void)cancelAction;
@end
