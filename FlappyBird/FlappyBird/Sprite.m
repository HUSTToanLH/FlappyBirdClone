//
//  Sprite.m
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Sprite.h"

@class Scene;
@implementation Sprite

-(instancetype)initWithName:(NSString *)name
                    ownView:(UIView *)view
                    inScene:(Scene *)scene
{
    if (self == [super init]) {
        self.name = name;
        self.view = view;
        self.scene = scene;
    }
    return self;
}

-(instancetype)initWithName:(NSString *)name
                    inScene:(Scene *)scene
{
    if (self == [super init]) {
        self.name = name;
        self.scene = scene;
    }
    return self;
}

-(void)animate
{
    
}
@end
