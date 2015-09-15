//
//  MainScene.h
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scene.h"

@interface MainScene : Scene
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGFloat bottomHeight;
@property(nonatomic,assign) BOOL play;
- (void)startTimer;
@end
