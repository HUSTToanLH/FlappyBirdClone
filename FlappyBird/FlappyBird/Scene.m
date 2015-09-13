//
//  Scene.m
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Scene.h"
#import "Sprite.h"

@implementation Scene

-(void)loadView
{
    [super loadView];
    self.spites = [NSMutableDictionary new];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)addSprite:(Sprite *)sprite
{
    [self.spites setObject:sprite
                    forKey:sprite.name];
    [self.view addSubview:sprite.view];
}

-(void)removeSprite:(Sprite *)sprite
{
    [self.spites removeObjectForKey:sprite.name];
    [sprite.view removeFromSuperview];
}

-(void)removeSpriteByName:(NSString *)spriteName
{
    UIView *removeView = self.spites[spriteName];
    [self.spites removeObjectForKey:spriteName];
    [removeView removeFromSuperview];
}

@end
