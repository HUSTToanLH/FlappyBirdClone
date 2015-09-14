//
//  Bird.m
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Bird.h"
#import <AVFoundation/AVFoundation.h>

@implementation Bird
{
    BOOL isJumping, isClick;
    CGFloat jumpVelocity, fallAcceleration, centerYJumping;
    UIImageView *flyingBird;
    UIImage *birdDied;
    
    AVAudioPlayer* wing, *die, *hit, *point, *swooshing;
}
-(instancetype)initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name inScene:scene];
    flyingBird = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 50, 35)];
    flyingBird.userInteractionEnabled = YES;
    flyingBird.multipleTouchEnabled = YES;
    birdDied = [UIImage imageNamed:@"bird1.png"];
    flyingBird.animationImages = @[[UIImage imageNamed:@"bird1.png"],[UIImage imageNamed:@"bird2.png"]];
    flyingBird.animationDuration = 0.5;
    [flyingBird startAnimating];
    flyingBird.backgroundColor = [UIColor blackColor];
    self.view = flyingBird;
    [self applyGestureRecognizer];
    self.alive = YES;
    isClick = YES;
    
    [self wingBird];
    [self dieBird];
    [self hitBird];
    [self pointBird];
    [self swooshingBird];
    
    return self;
}

-(void)applyGestureRecognizer{
    [self startJump];
    [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)]];
}

-(void)startJump{
    if (!isJumping) {
//        isJumping = NO;
        jumpVelocity = 30.0;
        fallAcceleration = 6.0;
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
        jumpVelocity = jumpVelocity - fallAcceleration;
        
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
    
    [UIView animateWithDuration:0.1 animations:^{
        if (self.view.center.y < [self.view superview].bounds.size.height - 30 +jumpVelocity) {
            self.view.center = CGPointMake(self.view.center.x, self.view.center.y - jumpVelocity);
            jumpVelocity = jumpVelocity - fallAcceleration - 5;
        }
        else{
            self.view.center = CGPointMake(self.view.center.x, [self.view superview].bounds.size.height - 30 + jumpVelocity);
        }
    } completion:^(BOOL finished) {
        if (self.view.center.y < [self.view superview].bounds.size.height - 30 +jumpVelocity) {
            [self died];
        }
    }];
}

-(void)jump{
    if (!self.alive) {
        return;
    }
    flyingBird.transform = CGAffineTransformMakeRotation(-M_PI_4*0.5);
    centerYJumping = self.view.center.y;

    [wing play];
    jumpVelocity = 30.0;
}

-(void)wingBird
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_wing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    wing = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                     error:&error];
    [wing prepareToPlay];
}

-(void)dieBird
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_die" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    die = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                  error:&error];
    [die prepareToPlay];
}

-(void)hitBird
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_hit" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    hit = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                 error:&error];
    [hit prepareToPlay];
}

-(void)pointBird
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sfx_point" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    point = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                 error:&error];
    [point prepareToPlay];
}

-(void)swooshingBird
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
