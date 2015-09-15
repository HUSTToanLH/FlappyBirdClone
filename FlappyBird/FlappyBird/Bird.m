//
//  Bird.m
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Bird.h"
#import "MainScene.h"
#import <AVFoundation/AVFoundation.h>

#define JUMP_VELOCITY 25.0
#define FALL_ACCELERATION 6.0
#define BIRD_1 @"bird1.png"
#define BIRD_2 @"bird2.png"

@implementation Bird
{
    BOOL isJumping;
    CGFloat jumpVelocity, centerYJumping, mainHeight, bottomHeight;
    UIImageView *flyingBird;
    UIImage *birdDied;
    MainScene *main;
    AVAudioPlayer* wing, *die, *hit, *point, *swooshing;
}

-(instancetype)initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name inScene:scene];
    flyingBird = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    flyingBird.animationImages = @[[UIImage imageNamed:BIRD_1],[UIImage imageNamed:BIRD_2]];
    flyingBird.animationDuration = 0.25;
    [flyingBird startAnimating];
    
    flyingBird.userInteractionEnabled = YES;
    flyingBird.multipleTouchEnabled = YES;
    [self applyGestureRecognizer];
    
    self.view = flyingBird;
    self.alive = YES;
    
    main = (MainScene*)[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0];
    mainHeight = main.height;
    bottomHeight = main.bottomHeight;
    
    birdDied = [UIImage imageNamed:BIRD_1];
    [self initSound];
    
    return self;
}

-(void)initSound{
    [self initWingSound];
    [self initDieSound];
    [self initHitSound];
    [self initPointSound];
    [self initSwooshingSound];
}

-(void)applyGestureRecognizer{
    [self startJump];
    [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)]];
}

-(void)startJump{
    if (!isJumping) {
        jumpVelocity = JUMP_VELOCITY;
    }
}

-(void)animate{
    if (!self.alive) {
        flyingBird.transform = CGAffineTransformMakeRotation(M_PI_2);
        [flyingBird stopAnimating];
        flyingBird.image = birdDied;
        [hit play];
        [die play];
        [self died];
    }
    else{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - jumpVelocity);
        jumpVelocity = jumpVelocity - FALL_ACCELERATION;
        
        if (jumpVelocity < -15) {
            jumpVelocity = -15;
        }
        
        if (self.view.center.y > centerYJumping) {
            [UIView animateWithDuration:0.2 animations:^{
                flyingBird.transform = CGAffineTransformMakeRotation(M_PI_2);
            } completion:nil];
        }
    }
}

-(void)died{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, main.view.bounds.size.width, main.view.bounds.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
//    [UIView animateWithDuration:0.01 animations:^{
//        [main.view addSubview:view];
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y - jumpVelocity);
        jumpVelocity = jumpVelocity - FALL_ACCELERATION;
        
    } completion:^(BOOL finished) {
        
        if (self.view.center.y < mainHeight - bottomHeight - 11) {
            [self died];
        }
        else{
            self.view.center = CGPointMake(self.view.center.x, mainHeight - bottomHeight - 11);
        }
        
    }];
}

-(void)jump{
    if (!self.alive) {
        return;
    }
    
    if (main.play == NO) {
        [main startTimer];
    }
    flyingBird.transform = CGAffineTransformMakeRotation(-M_PI_4*0.5);
    centerYJumping = self.view.center.y + JUMP_VELOCITY;

    [wing play];
    jumpVelocity = JUMP_VELOCITY;
}

-(void)initWingSound
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_wing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    wing = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                     error:&error];
    [wing prepareToPlay];
}

-(void)initDieSound
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_die" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    die = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                  error:&error];
    [die prepareToPlay];
}

-(void)initHitSound
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_hit" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    hit = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                 error:&error];
    [hit prepareToPlay];
}

-(void)initPointSound
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_point" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    point = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                 error:&error];
    [point prepareToPlay];
}

-(void)initSwooshingSound
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_swooshing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    swooshing = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                 error:&error];
    [swooshing prepareToPlay];
}

-(void)pointSound{
    [point play];
}

@end
