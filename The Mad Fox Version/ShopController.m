//
//  ShopController.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "ShopController.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import "AlertViewHelper.h"
#import "PlayController.h"

@implementation ShopController
+(CCScene*) scene {
    CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ShopController *layer = [ShopController node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    // return the scene
	return scene;
}
-(id)init{
    if(self = [super init]){
        
        _view= [[ShopView alloc]initWithDelegate:self];
        [self addChild:_view];
        isAlertViewVisible = NO;
        
    }
    return self;
}
#pragma mark PURCHASE WITH VIRTUAL MONEY
-(void)buy: (int)itemNumber_{
    
    
    UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
    long tempMoney = [ud getMoney];
    
    if(itemNumber_ == 1) {
        NSLog(@"Get 30 Hints");
        if(tempMoney < 2000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:2000];
            [ud addHints:30];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 2) {
        NSLog(@"Get 70 Hints");
        if(tempMoney < 3800) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:3800];
            [ud addHints:70];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 3) {
        NSLog(@"Get 130 Hints");
        if(tempMoney < 5000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            
            [ud removeMoney:5000];
            [ud addHints:130];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 4) {
        NSLog(@"Get 200 Hints");
        if(tempMoney < 6000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:6000];
            [ud addHints:200];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 5) {
        NSLog(@"Chapter 1");
        if(tempMoney < 5000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:5000];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 6) {
        NSLog(@"Chapter 2");
        if(tempMoney < 5000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:5000];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }
    else if(itemNumber_ == 7) {
        NSLog(@"Chapter 3");
        if(tempMoney < 5000) {
            if(isAlertViewVisible == NO) {
                [self showNoMoneyWarning];
            }
        }
        else {
            [ud removeMoney:5000];
            [[CCDirector sharedDirector]replaceScene:[ShopController scene]];
        }
    }


}
#pragma mark PURCHASE WITH REAL MONEY
-(void)purchaseWithRealMoney: (int)productNumber_ {
    
    if(productNumber_ == 1){
        NSLog(@"Buy 1500 Bubbles");
    }
    else if(productNumber_ == 2) {
        NSLog(@"Buy 4000 Bubbles");
    }
    else if(productNumber_ == 3) {
        NSLog(@"Buy 6000 Bubbles");
    }
    else if(productNumber_ == 4) {
        NSLog(@"Buy 20000 Bubbles");
    }
    else if(productNumber_ == 5) {
        NSLog(@"Buy Bundle");
    }
    else if(productNumber_ == 6) {
        NSLog(@"Buy -> Remove stars requred");
    }
}
-(void)restore {
    NSLog(@"restore");
}
-(void)back {
    NSLog(@"Back");
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"playview"] == YES) {
        NSLog(@"level: %i",shopLevel);
        [[CCDirector sharedDirector] replaceScene:[PlayController sceneWithLevelNumber:shopLevel]
                                   withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"playview"];
    }
    else {
        [[CCDirector sharedDirector] replaceScene:[MenuController scene]
                               withTransition:[CCTransition transitionRevealWithDirection:CCTransitionDirectionUp duration:SceneTransitionTime]];
    }
}
-(void)showNoMoneyWarning {
    isAlertViewVisible = YES;
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    [[AlertViewHelper sharedInstance]showAlertView:@"You don't have enough bubbles.\nPurchase bubbles to continue." title:@"Upps" cancelButton:@"OK" otherButton:nil view:_view positionX:viewSize.width/2 positionY:viewSize.height/2 fontName:fontInTheGame fontSize:18 selector:nil zOrder:18];
    
}
@end
