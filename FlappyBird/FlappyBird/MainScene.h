//
//  MainScene.h
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scene.h"
#import "Score.h"

@interface MainScene : Scene
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGFloat bottomHeight;
@property(nonatomic,assign) BOOL play;
@property(nonatomic,assign) BOOL hit;
@property(nonatomic,strong) IBOutlet UIView *startView;
@property(nonatomic,strong) IBOutlet UIView *endView;
@property(nonatomic,strong) IBOutlet Score *runScore;
@property(nonatomic,strong) IBOutlet UIButton *pause;
- (void)startTimer;
@end
