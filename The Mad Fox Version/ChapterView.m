//
//  ChapterView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/19/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "ChapterView.h"
#import "Constants.h"

@implementation ChapterView
@synthesize delegate = _delegate;
-(id)initWithDelegate:(id<ChapterDelegate>)delegateArg{
    if(self = [super init]){
        
        [self setDelegate:delegateArg];
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        self.contentSize = [[CCDirector sharedDirector] viewSize];
        [self setUserInteractionEnabled:YES];
        chapterNumber = 0;
        
        CCSprite* background = [CCSprite spriteWithImageNamed:BonusBackground];
        background.position = ccp(viewSize.width * 0.5, viewSize.height / 2);
        [self addChild:background];
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Chapters" fontName:fontInTheGame fontSize:40];
        title.position = ccp(viewSize.width / 2, viewSize.height / 2+(IS_IPAD?350:130));
        [self addChild:title];

        CCNode *chapters = [CCNode node];
        chapters.contentSize = CGSizeMake(viewSize.width * 3, viewSize.height);
        
        CCButton *chapter1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:chapter_1_image]];
        chapter1.position = ccp(viewSize.width * 0.5, viewSize.height / 2);
        [chapter1 setTarget:self selector:@selector(openChapter1)];
        CCLabelTTF *chapter_1_label = [CCLabelTTF labelWithString:chapter_1_label_string fontName:fontInTheGame fontSize:chapter_font_size];
        chapter_1_label.position = ccp(chapter1.contentSize.width / 2, chapter1.contentSize.height / 1.3 + (IS_IPAD?80:60));
        [chapter1 addChild:chapter_1_label];
        
        CCButton *chapter2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:chapter_2_image]];
        chapter2.position = ccp(viewSize.width * 1.5, viewSize.height / 2);
        [chapter2 setTarget:self selector:@selector(openChapter2)];
        CCLabelTTF *chapter_2_label = [CCLabelTTF labelWithString:chapter_2_label_string fontName:fontInTheGame fontSize:chapter_font_size];
        chapter_2_label.position = ccp(chapter2.contentSize.width / 2, chapter2.contentSize.height / 1.3 + (IS_IPAD?80:60));
        [chapter2 addChild:chapter_2_label];
        
        CCButton *chapter3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:chapter_3_image]];
        chapter3.position = ccp(viewSize.width * 2.5, viewSize.height / 2);
        [chapter3 setTarget:self selector:@selector(openChapter3)];
        CCLabelTTF *chapter_3_label = [CCLabelTTF labelWithString:chapter_3_label_string fontName:fontInTheGame fontSize:chapter_font_size];
        chapter_3_label.position = ccp(chapter3.contentSize.width / 2, chapter3.contentSize.height / 1.3 + (IS_IPAD?80:60));
        [chapter3 addChild:chapter_3_label];
        
        //[chapters addChild:background];
        [chapters addChild:chapter1];
        [chapters addChild:chapter2];
        [chapters addChild:chapter3];
        
        CCScrollView *cardScroll = [[CCScrollView alloc] initWithContentNode:chapters];
        [cardScroll setAnchorPoint:ccp(0.0f, 0.0f)];
        [cardScroll setPosition:ccp(0, 0)];
        [cardScroll setPagingEnabled:YES];
        [cardScroll setVerticalScrollEnabled:NO];
        [self addChild:cardScroll z:1 name:@"Chapters"];
        
        CCButton *back = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [back setTarget:self selector:@selector(back)];
        back.position = ccp(viewSize.width / 2, viewSize.height / 5);
        [self addChild:back];
        
        [back setZOrder:2];
        [title setZOrder:2];
    }
    return self;
}
-(void)back {
    [_delegate back];
}
-(void)openChapter1 {
    chapterNumber = 1;
    [_delegate loadChapter];
}
-(void)openChapter2 {
    chapterNumber = 2;
    [_delegate loadChapter];
}
-(void)openChapter3 {
    chapterNumber = 3;
    [_delegate loadChapter];
}
@end
