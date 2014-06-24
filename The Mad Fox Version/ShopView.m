//
//  ShopView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "ShopView.h"
#import "Constants.h"
#import "UserDefaultsUtils.h"
#import "ShopController.h"
#import "Constants.h"
#import "AlertViewHelper.h"

@implementation ShopView
@synthesize delegate = _delegate;
-(id)initWithDelegate:(id<ShopDelegate>)delegateArg{
    if(self = [super init]){
        
        [self setDelegate:delegateArg];
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        
        self.contentSize = [[CCDirector sharedDirector] viewSize];
        [self setUserInteractionEnabled:YES];
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstTimeInShop"] == YES) {
            [self setUserInteractionEnabled:NO];
            [[UserDefaultsUtils sharedInstance]addMoney:200];
            [[AlertViewHelper sharedInstance]showAlertView:@"First time here? You just received\n200 Bubbles for that!" title:@"Welcome" cancelButton:@"Cool" otherButton:nil view:self positionX:viewSize.width / 2 positionY:viewSize.height / 2 fontName:fontInTheGame fontSize:20 selector:nil zOrder:31];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isFirstTimeInShop"];
        }
        
        shopItemIndex = 0;
        UserDefaultsUtils* ud = [UserDefaultsUtils sharedInstance];
        
        CCButton *restore = [CCButton buttonWithTitle:RestoreTitleName fontName:fontInTheGame fontSize:BackButtonFontSize];
        [restore setTarget:self selector:@selector(restore)];
        restore.position = ccp(viewSize.width / 1.1, viewSize.height / 1.1);
        [self addChild:restore];
        
        CCButton *back = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [back setTarget:self selector:@selector(back)];
        back.position = ccp(viewSize.width / 5 - (IS_IPAD?120:50), viewSize.height / 1.1);
        [self addChild:back];
        
        NSString *temp = [NSString stringWithFormat:@"Bubbles: %li",[ud getMoney]];
        _moneyLabel = [CCLabelTTF labelWithString:temp fontName:fontInTheGame fontSize:ShopLabelFontSize];
        _moneyLabel.position = ccp(viewSize.width / 1.6, viewSize.height / 1.1);
        [self addChild:_moneyLabel];
        
        NSString *tempHints = [NSString stringWithFormat:@"Hints: %li",[ud getHints]];
        CCLabelTTF* hintlabel = [CCLabelTTF labelWithString:tempHints fontName:fontInTheGame fontSize:ShopLabelFontSize];
        hintlabel.position = ccp(viewSize.width / 3, viewSize.height / 1.1);
        [self addChild:hintlabel];
        
        int labelDistanceFromItem;
        int labelFontSize;
        
        if(IS_IPAD) {
            labelDistanceFromItem = 60;
            labelFontSize = 20;
        }
        else {
            labelDistanceFromItem = 40;
            labelFontSize = 20;
        }
        
        CCNode *items = [CCNode node];
        items.contentSize = CGSizeMake(viewSize.width * 1.7, viewSize.height*1.5);
        
        CCButton* item1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem1]];
        item1.position = ccp(viewSize.width * 0.5, viewSize.height / 1.5);
        [item1 setTarget:self selector:@selector(buy50)];
        [items addChild:item1];
        
        CCLabelTTF* item1Label = [CCLabelTTF labelWithString:@"2000 Bubbles" fontName:fontInTheGame fontSize:labelFontSize];
        item1Label.position = ccp(item1.contentSize.width / 2, item1.contentSize.height / 4 - labelDistanceFromItem);
        [item1 addChild:item1Label];
        
        CCButton* item2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem2]];
        item2.position = ccp(viewSize.width * 0.8 ,viewSize.height / 1.5);
        [item2 setTarget:self selector:@selector(buy100)];
        [items addChild:item2];
        
        CCLabelTTF* item2Label = [CCLabelTTF labelWithString:@"3800 Bubbles" fontName:fontInTheGame fontSize:labelFontSize];
        item2Label.position = ccp(item2.contentSize.width / 2, item2.contentSize.height / 4 - labelDistanceFromItem);
        [item2 addChild:item2Label];
        
        CCButton* item3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem3]];
        item3.position = ccp(viewSize.width * 1.1, viewSize.height / 1.5);
        [item3 setTarget:self selector:@selector(buy150)];
        [items addChild:item3];
        
        CCLabelTTF* item3Label = [CCLabelTTF labelWithString:@"5000 Bubbles" fontName:fontInTheGame fontSize:labelFontSize];
        item3Label.position = ccp(item3.contentSize.width / 2, item3.contentSize.height / 4 - labelDistanceFromItem);
        [item3 addChild:item3Label];
        
        CCButton* item4 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem3]];
        item4.position = ccp(viewSize.width * 1.4, viewSize.height / 1.5);
        [item4 setTarget:self selector:@selector(buy200)];
        [items addChild:item4];
        
        CCLabelTTF* item4Label = [CCLabelTTF labelWithString:@"6000 Bubbles" fontName:fontInTheGame fontSize:labelFontSize];
        item4Label.position = ccp(item4.contentSize.width / 2, item4.contentSize.height / 4 - labelDistanceFromItem);
        [item4Label setHorizontalAlignment:CCTextAlignmentCenter];
        [item4 addChild:item4Label];
        
        _itemScroll = [[CCScrollView alloc] initWithContentNode:items];
        [_itemScroll setAnchorPoint:ccp(0.0f, 0.0f)];
        [_itemScroll setPosition:ccp(0, viewSize.height / 2)];
        [_itemScroll setPagingEnabled:NO];
        [_itemScroll setVerticalScrollEnabled:NO];
        [self addChild:_itemScroll z:1 name:@"Item Scroll"];
        
        [self startMoving:item1 reverse:NO];
        [self startMoving:item2 reverse:YES];
        [self startMoving:item3 reverse:NO];
        [self startMoving:item4 reverse:YES];
        
        CCButton* pack1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"bubblegray.png"]];
        pack1.position = ccp(viewSize.width / 5.8-20, viewSize.height / 5);
        [pack1 setTarget:self selector:@selector(openPack1)];
        [self addChild:pack1];
        CCLabelTTF* pack1Label = [CCLabelTTF labelWithString:@"Get Hints" fontName:fontInTheGame fontSize:labelFontSize];
        pack1Label.position = ccp(pack1.contentSize.width / 2, pack1.contentSize.height / 4 - labelDistanceFromItem);
        [pack1Label setHorizontalAlignment:CCTextAlignmentCenter];
        [pack1 addChild:pack1Label];
        
        CCButton* pack2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"bubblegray.png"]];
        pack2.position = ccp(viewSize.width / 2.7, viewSize.height / 5);
        [pack2 setTarget:self selector:@selector(openPack2)];
        [self addChild:pack2];
        CCLabelTTF* pack2Label = [CCLabelTTF labelWithString:@"Chapters" fontName:fontInTheGame fontSize:labelFontSize];
        pack2Label.position = ccp(pack2.contentSize.width / 2, pack2.contentSize.height / 4 - labelDistanceFromItem);
        [pack2Label setHorizontalAlignment:CCTextAlignmentCenter];
        [pack2 addChild:pack2Label];
        
        CCButton* pack3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"bubblegray.png"]];
        pack3.position = ccp(viewSize.width / 1.7, viewSize.height / 5);
        [pack3 setTarget:self selector:@selector(openPack3)];
        [self addChild:pack3];
        CCLabelTTF* pack3Label = [CCLabelTTF labelWithString:@"Buy Packs" fontName:fontInTheGame fontSize:labelFontSize];
        pack3Label.position = ccp(pack3.contentSize.width / 2, pack3.contentSize.height / 4 - labelDistanceFromItem);
        [pack3Label setHorizontalAlignment:CCTextAlignmentCenter];
        [pack3 addChild:pack3Label];
        [self chapterItems];
        _chapterScroll.visible = NO;
        
        CCButton* pack4 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"bubblegray.png"]];
        pack4.position = ccp(viewSize.width / 1.2, viewSize.height / 5);
        [pack4 setTarget:self selector:@selector(openProducts)];
        [self addChild:pack4];
        CCLabelTTF* pack4Label = [CCLabelTTF labelWithString:@"Buy Bubbles" fontName:fontInTheGame fontSize:labelFontSize];
        pack4Label.position = ccp(pack4.contentSize.width / 2, pack4.contentSize.height / 4 - labelDistanceFromItem);
        [pack4Label setHorizontalAlignment:CCTextAlignmentCenter];
        [pack4 addChild:pack4Label];
        
        _removelimit = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"1.png"]];
        _removelimit.position = ccp(viewSize.width / 4, viewSize.height / 1.5);
        [_removelimit setTarget:self selector:@selector(removeStarsLimits)];
        [self addChild:_removelimit];
        CCLabelTTF* removeLimitLabel = [CCLabelTTF labelWithString:@"Removes the minimum stars\nrequire to play a level\n2.99$" fontName:fontInTheGame fontSize:20];
        removeLimitLabel.position = ccp(_removelimit.contentSize.width / 2, _removelimit.contentSize.height / 4 - labelDistanceFromItem-20);
        [removeLimitLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_removelimit addChild:removeLimitLabel];
        _removelimit.visible = NO;
        [self startMoving:_removelimit reverse:NO];
        
        _bundleButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"1.png"]];
        _bundleButton.position = ccp(viewSize.width / 1.3, viewSize.height / 1.5);
        [_bundleButton setTarget:self selector:@selector(buyBundle)];
        [self addChild:_bundleButton];
        CCLabelTTF* bundleLabel = [CCLabelTTF labelWithString:@"250 Hints + All Chapters +\n remove stars limits \n 6.99$" fontName:fontInTheGame fontSize:20];
        bundleLabel.position = ccp(_bundleButton.contentSize.width / 2, _bundleButton.contentSize.height / 4 - labelDistanceFromItem-20);
        [bundleLabel setHorizontalAlignment:CCTextAlignmentCenter];
        [_bundleButton addChild:bundleLabel];
        _bundleButton.visible = NO;
        [self startMoving:_bundleButton reverse:YES];
        
        [self loadTheProducts];
        _productScroll.visible = NO;
    }
    return self;
}


-(void)restore {
    [_delegate restore];
}
-(void)back {
    [_delegate back];
}
-(void)buy50 {
    shopItemIndex = 1;
    [_delegate buy:shopItemIndex];
}
-(void)buy100 {
    shopItemIndex = 2;
    [_delegate buy:shopItemIndex];
}
-(void)buy150 {
    shopItemIndex = 3;
    [_delegate buy:shopItemIndex];
}
-(void)buy200 {
    shopItemIndex = 4;
    [_delegate buy:shopItemIndex];
}
-(void)openPack1 {
    _itemScroll.visible = YES;
    _chapterScroll.visible = NO;
    _removelimit.visible = NO;
    _productScroll.visible = NO;
    _bundleButton.visible = NO;
}
-(void)openPack2 {
    _itemScroll.visible = NO;
    _chapterScroll.visible = YES;
    _removelimit.visible = NO;
    _productScroll.visible = NO;
    _bundleButton.visible = NO;
}
-(void)openPack3 {
    _itemScroll.visible = NO;
    _chapterScroll.visible = NO;
    _removelimit.visible = YES;
    _productScroll.visible = NO;
    _bundleButton.visible = YES;
}
-(void)openProducts {
    _itemScroll.visible = NO;
    _chapterScroll.visible = NO;
    _removelimit.visible = NO;
    _productScroll.visible = YES;
    _bundleButton.visible = NO;
}
-(void)buyChapter1 {
    shopItemIndex = 5;
    [_delegate buy:shopItemIndex];
    
}
-(void)buyChapter2 {
    shopItemIndex = 6;
    [_delegate buy:shopItemIndex];
   
}
-(void)buyChapter3 {
    shopItemIndex = 7;
    [_delegate buy:shopItemIndex];
   
}
-(void)removeStarsLimits {
    
    [_delegate purchaseWithRealMoney:6];
    
}
-(void)buyBundle {
    [_delegate purchaseWithRealMoney:5];
}
-(void)purchaseProduct1 {
    [_delegate purchaseWithRealMoney:1];
}
-(void)purchaseProduct2 {
    [_delegate purchaseWithRealMoney:2];
}
-(void)purchaseProduct3 {
    [_delegate purchaseWithRealMoney:3];
}
-(void)purchaseProduct4 {
    [_delegate purchaseWithRealMoney:4];
}
-(void)startMoving: (CCButton*)sprite_ reverse:(BOOL)reverse_{
    
    ccBezierConfig bezier;
    if(reverse_ == YES) {
        bezier.controlPoint_1 = ccp(0, -sprite_.contentSize.height/2);
        bezier.controlPoint_2 = ccp(0, sprite_.contentSize.height/4);
    }
    else {
        bezier.controlPoint_1 = ccp(0, sprite_.contentSize.height/2);
        bezier.controlPoint_2 = ccp(0, -sprite_.contentSize.height/4);
    }

    bezier.endPosition = ccp(0.0f,0.0f);
    
    id bezierForward = [CCActionBezierBy actionWithDuration:10.0 bezier:bezier];
    [sprite_ runAction:[CCActionRepeatForever actionWithAction:bezierForward]];

}
-(void)chapterItems {
    
    int labelDistanceFromItem;
    int labelFontSize;
    
    if(IS_IPAD) {
        labelDistanceFromItem = 60;
        labelFontSize = 30;
    }
    else {
        labelDistanceFromItem = 40;
        labelFontSize = 20;
    }

    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    
    CCNode *items = [CCNode node];
    items.contentSize = CGSizeMake(viewSize.width * 1.7, viewSize.height*1.5);
    
    CCButton* item1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ChapterItem1]];
    item1.position = ccp(viewSize.width * 0.5, viewSize.height / 1.5);
    [item1 setTarget:self selector:@selector(buyChapter1)];
    [items addChild:item1];
    
    CCLabelTTF* item1Label = [CCLabelTTF labelWithString:@"Fluffy World" fontName:fontInTheGame fontSize:labelFontSize];
    item1Label.position = ccp(item1.contentSize.width / 2, item1.contentSize.height / 4 - labelDistanceFromItem);
    [item1 addChild:item1Label];
    
    CCButton* item2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ChapterItem2]];
    item2.position = ccp(viewSize.width * 0.8 ,viewSize.height / 1.5);
    [item2 setTarget:self selector:@selector(buyChapter2)];
    [items addChild:item2];
    
    CCLabelTTF* item2Label = [CCLabelTTF labelWithString:@"Dark World" fontName:fontInTheGame fontSize:labelFontSize];
    item2Label.position = ccp(item2.contentSize.width / 2, item2.contentSize.height / 4 - labelDistanceFromItem);
    [item2 addChild:item2Label];
    
    CCButton* item3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ChapterItem3]];
    item3.position = ccp(viewSize.width * 1.1, viewSize.height / 1.5);
    [item3 setTarget:self selector:@selector(buyChapter3)];
    [items addChild:item3];
    
    CCLabelTTF* item3Label = [CCLabelTTF labelWithString:@"Plazma World" fontName:fontInTheGame fontSize:labelFontSize];
    item3Label.position = ccp(item3.contentSize.width / 2, item3.contentSize.height / 4 - labelDistanceFromItem);
    [item3 addChild:item3Label];
    
    _chapterScroll = [[CCScrollView alloc] initWithContentNode:items];
    [_chapterScroll setAnchorPoint:ccp(0.0f, 0.0f)];
    [_chapterScroll setPosition:ccp(0, viewSize.height / 2)];
    [_chapterScroll setPagingEnabled:NO];
    [_chapterScroll setVerticalScrollEnabled:NO];
    [self addChild:_chapterScroll z:1 name:@"Chapter Scroll"];
    
    [self startMoving:item1 reverse:NO];
    [self startMoving:item2 reverse:YES];
    [self startMoving:item3 reverse:NO];

}
-(void)loadTheProducts {
    
    int labelDistanceFromItem;
    int labelFontSize;
    
    if(IS_IPAD) {
        labelDistanceFromItem = 60;
        labelFontSize = 30;
    }
    else {
        labelDistanceFromItem = 40;
        labelFontSize = 20;
    }
    
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];

    CCNode *items = [CCNode node];
    items.contentSize = CGSizeMake(viewSize.width * 1.7, viewSize.height*1.5);
    
    CCButton* item1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem1]];
    item1.position = ccp(viewSize.width * 0.5, viewSize.height / 1.5);
    [item1 setTarget:self selector:@selector(purchaseProduct1)];
    [items addChild:item1];
    
    CCLabelTTF* item1Label = [CCLabelTTF labelWithString:@"0.99$" fontName:fontInTheGame fontSize:labelFontSize];
    item1Label.position = ccp(item1.contentSize.width / 2, item1.contentSize.height / 4 - labelDistanceFromItem);
    [item1 addChild:item1Label];
    
    CCButton* item2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem2]];
    item2.position = ccp(viewSize.width * 0.8 ,viewSize.height / 1.5);
    [item2 setTarget:self selector:@selector(purchaseProduct2)];
    [items addChild:item2];
    
    CCLabelTTF* item2Label = [CCLabelTTF labelWithString:@"1.99$" fontName:fontInTheGame fontSize:labelFontSize];
    item2Label.position = ccp(item2.contentSize.width / 2, item2.contentSize.height / 4 - labelDistanceFromItem);
    [item2 addChild:item2Label];
    
    CCButton* item3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem3]];
    item3.position = ccp(viewSize.width * 1.1, viewSize.height / 1.5);
    [item3 setTarget:self selector:@selector(purchaseProduct3)];
    [items addChild:item3];
    
    CCLabelTTF* item3Label = [CCLabelTTF labelWithString:@"3.99$" fontName:fontInTheGame fontSize:labelFontSize];
    item3Label.position = ccp(item3.contentSize.width / 2, item3.contentSize.height / 4 - labelDistanceFromItem);
    [item3 addChild:item3Label];
    
    CCButton* item4 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:ShopItem3]];
    item4.position = ccp(viewSize.width * 1.4, viewSize.height / 1.5);
    [item4 setTarget:self selector:@selector(purchaseProduct4)];
    [items addChild:item4];
    
    CCLabelTTF* item4Label = [CCLabelTTF labelWithString:@"6.99$" fontName:fontInTheGame fontSize:labelFontSize];
    item4Label.position = ccp(item4.contentSize.width / 2, item4.contentSize.height / 4 - labelDistanceFromItem);
    [item4Label setHorizontalAlignment:CCTextAlignmentCenter];
    [item4 addChild:item4Label];
    
    _productScroll = [[CCScrollView alloc] initWithContentNode:items];
    [_productScroll setAnchorPoint:ccp(0.0f, 0.0f)];
    [_productScroll setPosition:ccp(0, viewSize.height / 2)];
    [_productScroll setPagingEnabled:NO];
    [_productScroll setVerticalScrollEnabled:NO];
    [self addChild:_productScroll z:1 name:@"Product Scroll"];
    
    [self startMoving:item1 reverse:NO];
    [self startMoving:item2 reverse:YES];
    [self startMoving:item3 reverse:NO];
    [self startMoving:item4 reverse:YES];

}

@end
