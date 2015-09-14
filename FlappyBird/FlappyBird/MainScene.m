//
//  MainScene.m
//  TechMasterGame
//
//  Created by TaiND on 8/18/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "MainScene.h"
#import "TopPipe.h"
#import "BottomPipe.h"
#import "Bottom.h"
#import "Bird.h"

#define spaceForBird 200
#define spaceForPipe 250

@implementation MainScene
{
    Bird *bird;
    TopPipe *pipeTop1, *pipeTop2;
    BottomPipe *pipeBottom1, *pipeBottom2;
    Bottom *bottom1, *bottom2, *top1, *top2;
    
    CGSize bottomSize;
    NSTimer *timer;
    CGFloat birdJumpSpeed, spaceBottom;
    CGFloat haftPipe;
    CGFloat maxTopCenter;
    CGFloat minTopCenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat statusAndNaviHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusAndNaviHeight);
    
    birdJumpSpeed = 4.0;
    
    [self addBackground];
    [self addPipe];
    [self addBottom];
    [self addBird];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                             target:self
                                           selector:@selector(gameLoop)
                                           userInfo:nil
                                            repeats:true];
    
    
}

-(void)addBackground{
    UIImage *imgBackground= [UIImage imageNamed:@"background.png"];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    background.image = imgBackground;
    [self.view addSubview:background];
}

-(void)addBottom
{
    UIImage *imgBottom = [UIImage imageNamed:@"bottom.png"];
    spaceBottom = imgBottom.size.height*0.5;
    bottomSize = CGSizeMake(self.size.width, imgBottom.size.height*0.5);
    bottom1 = [[Bottom alloc] initWithName:@"bottom1"
                                             ownView:[[UIImageView alloc] initWithImage:imgBottom]
                                             inScene:self];
    bottom1.view.frame = CGRectMake(0, self.size.height - bottomSize.height, bottomSize.width, bottomSize.height);
    
    bottom2 = [[Bottom alloc] initWithName:@"bottom2"
                                             ownView:[[UIImageView alloc] initWithImage:imgBottom]
                                             inScene:self];
    bottom2.view.frame = CGRectMake(bottomSize.width, self.size.height - bottomSize.height, bottomSize.width, bottomSize.height);
    
    [self.view addSubview:bottom1.view];
    [self.view addSubview:bottom2.view];
    
    //add top
    top1 = [[Bottom alloc] initWithName:@"top1"
                                   ownView:[[UIImageView alloc] initWithImage:imgBottom]
                                   inScene:self];
    top1.view.frame = CGRectMake(0, -200, bottomSize.width, bottomSize.height);
    
    top2 = [[Bottom alloc] initWithName:@"top2"
                                   ownView:[[UIImageView alloc] initWithImage:imgBottom]
                                   inScene:self];
    top2.view.frame = CGRectMake(bottomSize.width, -200, bottomSize.width, bottomSize.height);
    
    [self.view addSubview:top1.view];
    [self.view addSubview:top2.view];
}

-(void)moveBottomAtSpeed:(CGFloat)speed
{
    bottom1.view.center = CGPointMake(bottom1.view.center.x - speed, bottom1.view.center.y);
    bottom2.view.center = CGPointMake(bottom2.view.center.x - speed, bottom2.view.center.y);
    
    if (bottom1.view.frame.origin.x + bottomSize.width <= 0) {
        bottom1.view.frame = CGRectMake(bottom2.view.frame.origin.x + bottomSize.width, bottom1.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    if (bottom2.view.frame.origin.x + bottomSize.width <= 0) {
        bottom2.view.frame = CGRectMake(bottom1.view.frame.origin.x + bottomSize.width, bottom2.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    //move top
    top1.view.center = CGPointMake(top1.view.center.x - speed, top1.view.center.y);
    top2.view.center = CGPointMake(top2.view.center.x - speed, top2.view.center.y);
    
    if (top1.view.frame.origin.x + bottomSize.width <= 0) {
        top1.view.frame = CGRectMake(top2.view.frame.origin.x + bottomSize.width, top1.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    if (top2.view.frame.origin.x + bottomSize.width <= 0) {
        top2.view.frame = CGRectMake(top1.view.frame.origin.x + bottomSize.width, top2.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
}

-(void)addPipe
{
    UIImage *imgBottom = [UIImage imageNamed:@"bottom.png"];
    spaceBottom = imgBottom.size.height*0.5;
    
    haftPipe = [Sprite height]*0.5;
    maxTopCenter = self.size.height - spaceBottom - spaceForBird - 20 - haftPipe;
    minTopCenter = 20 - haftPipe;
    
    pipeTop1 = [[TopPipe alloc] initWithName:@"pipeTop1" inScene:self];
    pipeTop1.view.center = CGPointMake(self.view.bounds.size.width*4/3, [self randomCenterY]);
    
    pipeBottom1 = [[BottomPipe alloc] initWithName:@"pipeBottom1" inScene:self];
    pipeBottom1.view.center = CGPointMake(pipeTop1.view.center.x, pipeTop1.view.center.y + 2*haftPipe + spaceForBird);
    
    pipeTop2 = [[TopPipe alloc] initWithName:@"pipeTop2" inScene:self];
    pipeTop2.view.center = CGPointMake(pipeTop1.view.center.x + spaceForPipe, [self randomCenterY]);
    
    pipeBottom2 = [[BottomPipe alloc] initWithName:@"pipeBottom2" inScene:self];
    pipeBottom2.view.center = CGPointMake(pipeTop2.view.center.x, pipeTop2.view.center.y + 2*haftPipe + spaceForBird);
    
    //add subview
    [self.view addSubview:pipeTop1.view];
    [self.view addSubview:pipeTop2.view];
    [self.view addSubview:pipeBottom1.view];
    [self.view addSubview:pipeBottom2.view];
}

-(CGFloat)randomCenterY{
    return arc4random()%(int)(maxTopCenter - minTopCenter) + minTopCenter;
}

-(void)movePipeAtSpeed:(CGFloat)speed
{
    pipeTop1.view.center = CGPointMake(pipeTop1.view.center.x - speed, pipeTop1.view.center.y);
    pipeTop2.view.center = CGPointMake(pipeTop2.view.center.x - speed, pipeTop2.view.center.y);
    
    pipeBottom1.view.center = CGPointMake(pipeBottom1.view.center.x - speed, pipeBottom1.view.center.y);
    pipeBottom2.view.center = CGPointMake(pipeBottom2.view.center.x - speed, pipeBottom2.view.center.y);
    
    if (pipeTop1.view.frame.origin.x + pipeTop1.view.bounds.size.width <= 0) {
        pipeTop1.view.center = CGPointMake(pipeTop2.view.center.x + spaceForPipe, [self randomCenterY]);
    }
    
    if (pipeTop2.view.frame.origin.x + pipeTop2.view.bounds.size.width <= 0) {
        pipeTop2.view.center = CGPointMake(pipeTop1.view.center.x + spaceForPipe, [self randomCenterY]);
    }
    
    if (pipeBottom1.view.frame.origin.x + pipeBottom1.view.bounds.size.width <= 0) {
        pipeBottom1.view.center = CGPointMake(pipeBottom2.view.center.x + spaceForPipe, pipeTop1.view.center.y + 2*haftPipe + spaceForBird);
    }
    
    if (pipeBottom2.view.frame.origin.x + pipeBottom2.view.bounds.size.width <= 0) {
        pipeBottom2.view.center = CGPointMake(pipeBottom1.view.center.x + spaceForPipe, pipeTop2.view.center.y + 2*haftPipe + spaceForBird);
    }
}

-(void)addBird
{
    bird = [[Bird alloc] initWithName:@"bird"
                              inScene:self];
    bird.y0 = (self.size.height - bird.view.bounds.size.height)*0.5;
    bird.view.center = CGPointMake(self.size.width*0.5, bird.y0);
    [self.view addSubview:bird.view];
}

-(void)playGame{
    //pipe top
    if (CGRectIntersectsRect(bird.view.frame, pipeTop1.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeTop2.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeBottom1.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeBottom2.view.frame)) {
        [self gameOver];
    }
    
    //top
    if (CGRectIntersectsRect(bird.view.frame, top1.view.frame) || CGRectIntersectsRect(bird.view.frame, top2.view.frame) || CGRectIntersectsRect(bird.view.frame, bottom1.view.frame) || CGRectIntersectsRect(bird.view.frame, bottom2.view.frame)) {
        [self gameOver];
    }
}

-(void)gameOver{
    [timer invalidate];
    bird.alive = NO;
}

-(void)gameLoop
{
    [self moveBottomAtSpeed:birdJumpSpeed];
    [self movePipeAtSpeed:birdJumpSpeed];
    [self playGame];
    
    if (bird.view.center.y >= self.size.height - spaceBottom) {
        [self gameOver];
    }
    [bird animate];
    
}



@end
