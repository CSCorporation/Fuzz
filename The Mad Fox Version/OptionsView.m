//
//  OptionsView.m
//  The Mad Fox Version
//
//  Created by Viktor Todorov on 5/14/14.
//  Copyright 2014 Viktor Todorov. All rights reserved.
//

#import "OptionsView.h"
#import "Constants.h"

@implementation OptionsView
@synthesize delegate = _delegate;

-(id)initWithDelegate:(id<OptionsDelegate>) delegateArg {
    
    if(self = [super init]){
        [self setDelegate:delegateArg];
        
        CGSize viewSize = [[CCDirector sharedDirector] viewSize];
        CCSprite* background = [CCSprite spriteWithImageNamed:OptionsBackground];
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];
        
        [_delegate musicConfiguration];
        
        
        CCButton *backButton = [CCButton buttonWithTitle:BackButtonTitle fontName:fontInTheGame fontSize:BackButtonFontSize];
        [backButton setTarget:self selector:@selector(goBack)];
        backButton.position = ccp(viewSize.width / 2, viewSize.height / 5);
        [self addChild:backButton];

        
    }
    return self;
}
-(void)goBack {
    [_delegate goBack];
}
@end
