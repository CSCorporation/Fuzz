//
//  HintWeapon.h
//  TheMadFox
//
//  Created by Aleksandar Angelov on 12/2/13.
//  Copyright (c) 2013 Aleksandar Angelov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HintWeapon : NSObject

-(id)initWithWeapon:(NSString*)weaponArg cordX:(int)cordXArg cordY:(int)cordYArg;
-(id)initWithWeapon:(NSString*)weaponArg edgeIndex:(int)edgeIndexArg;
@property (nonatomic,retain) NSString *weapon;
@property (nonatomic,assign) int cordX;
@property (nonatomic,assign) int cordY;
@property (nonatomic,assign) int edgeIndex;

@end
