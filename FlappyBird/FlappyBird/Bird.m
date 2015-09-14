//
//  Bird.m
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Bird.h"

@implementation Bird
{
    BOOL isJumping, isClick;
    CGFloat jumpVelocity, fallAcceleration;
    UIImageView *flyingBird;
}
-(instancetype)initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name inScene:scene];
    flyingBird = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, 50, 35)];
    flyingBird.userInteractionEnabled = YES;
    flyingBird.multipleTouchEnabled = YES;
    flyingBird.animationImages = @[[UIImage imageNamed:@"bird1.png"],[UIImage imageNamed:@"bird2.png"]];
    flyingBird.animationDuration = 0.5;
    [flyingBird startAnimating];
    flyingBird.backgroundColor = [UIColor blackColor];
    self.view = flyingBird;
    [self applyGestureRecognizer];
    self.alive = YES;
    isClick = YES;
    
    return self;
}

-(void)applyGestureRecognizer{
    [self startJump];
    [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jump)]];
}

-(void)startJump{
    if (!isJumping) {
        isJumping = YES;
        jumpVelocity = 30.0;
        fallAcceleration = 6.0;
    }
}

-(void)animate{
    if (!isJumping) {
        return;
    }
    
    if (!self.alive) {
        jumpVelocity = 0;
        fallAcceleration = 0;
    }
    
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - jumpVelocity);
    jumpVelocity = jumpVelocity - fallAcceleration;
    
    if (jumpVelocity < -15) {
        jumpVelocity = -15;
    }
    
    if (jumpVelocity <= 0) {
//        [UIView animateWithDuration:1 animations:^{
//            flyingBird.transform = CGAffineTransformMakeRotation(M_PI_2);
//        } completion:nil];
    }
    
    if (jumpVelocity > 0) {
        flyingBird.transform = CGAffineTransformMakeRotation(-M_PI_4*0.3);
    }
}

-(void)jump{
    if (!self.alive) {
        return;
    }
    
    if (!isJumping) {
        return;
    }
    jumpVelocity = 30.0;
}

@end
