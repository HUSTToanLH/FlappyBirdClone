//
//  Scene.h
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sprite.h"

@class  Sprite;
@interface Scene : UIViewController
@property(nonatomic, strong) NSMutableDictionary *spites;
@property(nonatomic, assign) CGSize size;

-(void)addSprite:(Sprite *)sprite;
-(void)removeSprite:(Sprite *)sprite;
-(void)removeSpriteByName:(NSString *)spriteName;

@end
