//
//  ShopView.h
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/16/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCScrollView.h"

@protocol ShopDelegate
-(void)buy: (int)itemNumber_;
-(void)restore;
-(void)back;
-(void)purchaseWithRealMoney: (int)productNumber_;
@end
@interface ShopView : CCNode {
    id<ShopDelegate> _delegate;
    NSMutableArray* _itemsArray;
    CCLabelTTF* _moneyLabel;
    CCScrollView *_itemScroll;
    CCScrollView *_packScroll;
    CCScrollView *_chapterScroll;
    CCScrollView *_productScroll;
    CCButton* _removelimit;
    CCButton* _bundleButton;
}
-(id)initWithDelegate:(id<ShopDelegate>) delegateArg;
@property (nonatomic,retain) id<ShopDelegate> delegate;

@end
