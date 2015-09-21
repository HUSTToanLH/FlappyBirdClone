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


#define spaceForBird 160 //deascending for hard
#define spaceForPipe 260 //deascending for hard
#define jumpSpeed 7.0 //ascending for hard
#define timerLoop 0.05
#define pointToUpLevel_1 100
#define pointToUpLevel_2 100
#define pointToUpLevel_3 100

@implementation MainScene
{
    Bird *bird;
    TopPipe *pipeTop1, *pipeTop2;
    BottomPipe *pipeBottom1, *pipeBottom2;
    Bottom *bottom1, *bottom2, *top1, *top2;
    
    CGSize bottomSize;
    NSTimer *timer;
    CGFloat birdJumpSpeed;
    CGFloat haftPipe;
    CGFloat maxTopCenter;
    CGFloat minTopCenter;
    CGFloat spaceForBirdChange;
    UIButton *start, *share;
    UIImageView *newScore;
    BOOL restart, resetFramePipe, gamePause;
    int point;
    NSInteger hightScore;
    Score *endScore, *endHightScore;
}

#pragma mark - init main
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //set height using of main view
    CGFloat statusAndNaviHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusAndNaviHeight);
    _height = self.size.height;
    
    //init content
    [self setHightScore];
    restart = NO;
    gamePause = NO;
    [self initSubview];
    
}

-(void)setHightScore{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"HightScore"] != 0) {
        hightScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HightScore"];
    }else{
        hightScore = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:hightScore forKey:@"HightScore"];
    }
}

-(void)initSubview{
    _play = NO;
    birdJumpSpeed = jumpSpeed;
    point = 0;
    spaceForBirdChange = spaceForBird;
    
    [self addBackground];
    [self addPipe];
    [self addLogoAndGuide];
    [self addEndView];
    [self addBird];
    [self addTopAndBottom];
    [self addScoreImage];
    [self addPauseAndExitButton];
}

#pragma mark - init subviews
-(void)addBackground{
    UIImage *imgBackground= [UIImage imageNamed:@"background.png"];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    background.image = imgBackground;
    [self.view addSubview:background];
}

-(void)addPipe
{
    UIImage *imgBottom = [UIImage imageNamed:@"bottom.png"];
    _bottomHeight = imgBottom.size.height*0.5;
    
    haftPipe = [Sprite height]*0.5;
    maxTopCenter = self.size.height - _bottomHeight - spaceForBirdChange - 30 - haftPipe;
    minTopCenter = 30 - haftPipe;
    
    pipeTop1 = [[TopPipe alloc] initWithName:@"pipeTop1" inScene:self];
    pipeTop1.view.center = CGPointMake(self.view.bounds.size.width*4/3, [self randomCenterY]);
    
    pipeBottom1 = [[BottomPipe alloc] initWithName:@"pipeBottom1" inScene:self];
    pipeBottom1.view.center = CGPointMake(pipeTop1.view.center.x, pipeTop1.view.center.y + 2*haftPipe + spaceForBirdChange);
    
    pipeTop2 = [[TopPipe alloc] initWithName:@"pipeTop2" inScene:self];
    pipeTop2.view.center = CGPointMake(pipeTop1.view.center.x + spaceForPipe, [self randomCenterY]);
    
    pipeBottom2 = [[BottomPipe alloc] initWithName:@"pipeBottom2" inScene:self];
    pipeBottom2.view.center = CGPointMake(pipeTop2.view.center.x, pipeTop2.view.center.y + 2*haftPipe + spaceForBirdChange);
    
    //add subview
    [self.view addSubview:pipeTop1.view];
    [self.view addSubview:pipeTop2.view];
    [self.view addSubview:pipeBottom1.view];
    [self.view addSubview:pipeBottom2.view];
    
    resetFramePipe = YES;
}

-(void)addLogoAndGuide{
    _startView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width*0.5, self.size.height*0.5)];
    _startView.center = CGPointMake(self.size.width*0.5, self.size.height*0.5);
    _startView.backgroundColor = [UIColor clearColor];
    
    UIImage *logoImg = [UIImage imageNamed:@"logo.png"];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.size.width*0.5, self.size.width*0.5*(logoImg.size.height/logoImg.size.width))];
    logo.image = logoImg;
    [_startView addSubview:logo];
    
    UIImage *guideImg = [UIImage imageNamed:@"guide.png"];
    CGSize size = CGSizeMake(self.size.height*0.2,self.size.height*0.2*(728/572)+25);
    
    UIImageView *guide = [[UIImageView alloc] initWithFrame:CGRectMake(self.size.width*0.5 - size.width, logo.bounds.size.height + 20, size.width,size.height)];
    guide.image = guideImg;
    [_startView addSubview:guide];
    
    [self.view addSubview:_startView];
}

-(void)addEndView{
    UIImage *gameOverImg = [UIImage imageNamed:@"gameover.png"];
    _endView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width-60, (self.size.width-60)*(gameOverImg.size.height/gameOverImg.size.width))];
    _endView.center = CGPointMake(self.size.width*0.5, -self.size.height*0.5);
    _endView.backgroundColor = [UIColor clearColor];
    
    UIImageView *gameOver = [[UIImageView alloc] initWithFrame:_endView.bounds];
    gameOver.image = gameOverImg;
    [_endView addSubview:gameOver];
    
    UIImage *okImg = [UIImage imageNamed:@"okButton.png"];
    CGSize okSize = CGSizeMake((_endView.bounds.size.width - 60)/2, (_endView.bounds.size.width - 60)*(okImg.size.height/okImg.size.width)/2);
    start = [[UIButton alloc] initWithFrame:CGRectMake(15, _endView.bounds.size.height - okSize.height, okSize.width,okSize.height)];
    [start setImage:okImg forState:UIControlStateNormal];
    [_endView addSubview:start];
    [start addTarget:self action:@selector(onClickStart) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *shareImg = [UIImage imageNamed:@"shareButton.png"];
    share = [[UIButton alloc] initWithFrame:CGRectMake(_endView.bounds.size.width - 15 - okSize.width, _endView.bounds.size.height - okSize.height, okSize.width,okSize.height)];
    [share setImage:shareImg forState:UIControlStateNormal];
    [_endView addSubview:share];
    [share addTarget:self action:@selector(onClickShare) forControlEvents:UIControlEventTouchUpInside];

    UIImage *newImg = [UIImage imageNamed:@"newLabel.png"];
    newScore = [[UIImageView alloc] initWithFrame:CGRectMake(180, 170, 50, 50*(newImg.size.height/newImg.size.width))];
    newScore.image = newImg;
    newScore.hidden = YES;
    [_endView addSubview:newScore];
    
    [self.view addSubview:_endView];
}

-(void)addBird
{
    bird = [[Bird alloc] initWithName:@"bird"
                              inScene:self];
    bird.y0 = (self.size.height - bird.view.bounds.size.height)*0.5;
    bird.view.center = CGPointMake(self.size.width*2/5 - 10, bird.y0);
    [self.view addSubview:bird.view];
    bird.alive = YES;
}

-(void)addTopAndBottom
{
    UIImage *image = [UIImage imageNamed:@"bottom.png"];
    _bottomHeight = image.size.height*0.5;
    
    bottomSize = CGSizeMake(self.size.width, _bottomHeight);
    bottom1 = [[Bottom alloc] initWithName:@"bottom1"
                                   ownView:[[UIImageView alloc] initWithImage:image]
                                   inScene:self];
    bottom1.view.frame = CGRectMake(0, self.size.height- _bottomHeight, bottomSize.width, bottomSize.height);
    
    bottom2 = [[Bottom alloc] initWithName:@"bottom2"
                                   ownView:[[UIImageView alloc] initWithImage:image]
                                   inScene:self];
    bottom2.view.frame = CGRectMake(bottomSize.width, self.size.height - _bottomHeight, bottomSize.width, bottomSize.height);
    
    [self.view addSubview:bottom1.view];
    [self.view addSubview:bottom2.view];
    
    //add top
    top1 = [[Bottom alloc] initWithName:@"top1"
                                ownView:[[UIImageView alloc] initWithImage:image]
                                inScene:self];
    top1.view.frame = CGRectMake(0, -_bottomHeight, bottomSize.width, bottomSize.height);
    
    top2 = [[Bottom alloc] initWithName:@"top2"
                                ownView:[[UIImageView alloc] initWithImage:image]
                                inScene:self];
    top2.view.frame = CGRectMake(bottomSize.width, -_bottomHeight, bottomSize.width, bottomSize.height);
    
    [self.view addSubview:top1.view];
    [self.view addSubview:top2.view];
}

-(void)addScoreImage{
    _runScore = [[Score alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    _runScore.backgroundColor = [UIColor clearColor];
    _runScore = [_runScore getNumber:0];
    _runScore.center = CGPointMake(self.size.width *0.5, self.size.height *0.5 - 250);
    _runScore.hidden = YES;
    [self.view addSubview:_runScore];
    
    //set score for end view
    endScore = [[Score alloc] initWithFrame:CGRectMake(250, 140, 40, 20)];
    endScore.backgroundColor = [UIColor clearColor];
    endScore = [endScore getNumber:0];
    [_endView addSubview:endScore];
    
    endHightScore = [[Score alloc] initWithFrame:CGRectMake(250, 200, 40, 20)];
    endHightScore.backgroundColor = [UIColor clearColor];
    endHightScore = [endHightScore getNumber:(int)hightScore];
    [_endView addSubview:endHightScore];
}

-(void)addPauseAndExitButton{
    _pause = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 25, 25)];
    UIImage *pauseImg = [UIImage imageNamed:@"pauseButton.png"];
    [_pause setImage:pauseImg forState:UIControlStateNormal];
    [_pause addTarget:self action:@selector(onClickPause) forControlEvents:UIControlEventTouchUpInside];
    _pause.hidden = YES;
    [self.view addSubview:_pause];
    
    UIButton *exit = [[UIButton alloc] initWithFrame:CGRectMake(self.size.width - 40, 15, 25, 25)];
    UIImage *exitImg = [UIImage imageNamed:@"exitButton.png"];
    [exit setImage:exitImg forState:UIControlStateNormal];
    [exit addTarget:self action:@selector(onClickExit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exit];
    
    
}

#pragma mark - common function

-(void)onClickStart{
    _play = NO;
    _runScore.hidden = NO;
    _pause.hidden = NO;
    [self.view bringSubviewToFront:_runScore];
    if (restart) {
        [self removeAllSubview];
        [self initSubview];
        [self.view setNeedsDisplay];
    }
    restart = NO;
}

-(void)onClickShare{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *shareToFaceBook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [shareToFaceBook setInitialText:[NSString stringWithFormat:@"Copied by ToanLH. Score: %d", point]];
        [shareToFaceBook addImage:[UIImage imageNamed:@"mu.jpg"]];
        [shareToFaceBook addURL:[NSURL URLWithString:@"http://www.haivainoi.com"]];
        [self presentViewController:shareToFaceBook animated:YES completion:nil];
    }
}

-(void)onClickPause{
    if (gamePause) {
        gamePause = NO;
        [self startTimer];
        UIImage *pauseImg = [UIImage imageNamed:@"pauseButton.png"];
        [_pause setImage:pauseImg forState:UIControlStateNormal];
    }
    else{
        gamePause = YES;
        [self stopTimer];
        UIImage *playImg = [UIImage imageNamed:@"playButton.png"];
        [_pause setImage:playImg forState:UIControlStateNormal];
    }
}

-(void)onClickExit{
    exit(0);
}

-(void)removeAllSubview{
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    
    for (UIImageView *imageview in [self.view subviews]) {
        [imageview removeFromSuperview];
    }
}

#pragma mark - common function for game play

- (void)startTimer{
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:timerLoop
                                                 target:self
                                               selector:@selector(gameLoop)
                                               userInfo:nil
                                                repeats:true];
    }
}

- (void)stopTimer{
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}

-(void)changeSpaceForBird:(CGFloat)space{
    spaceForBirdChange = space;
    maxTopCenter = self.size.height - _bottomHeight - spaceForBirdChange - 30 - haftPipe;
}

-(CGFloat)randomCenterY{
    return arc4random()%(int)(maxTopCenter - minTopCenter) + minTopCenter;
}

-(void)setScore{
    point++;
    _runScore = [_runScore getNumber:point];
    _runScore.center = CGPointMake(self.size.width *0.5, self.size.height *0.5 - 250);
    endScore = [endScore getNumber:point];
    if (point > hightScore) {
        hightScore = point;
        newScore.hidden = NO;
        
        endHightScore = [endHightScore getNumber:(int)hightScore];
        [[NSUserDefaults standardUserDefaults] setInteger:point forKey:@"HightScore"];
    }
    
    if (point == pointToUpLevel_1 - 1) {
        [self changeSpaceForBird:170];
    }
    
    if (point == pointToUpLevel_2 - 1) {
        birdJumpSpeed = 8;
    }
    
    if (point == pointToUpLevel_3 - 1) {
        [self changeSpaceForBird:150];
        birdJumpSpeed = 10;
    }
}

#pragma mark - method for playgame

-(void)movePipeAtSpeed:(CGFloat)speed
{
    pipeTop1.view.center = CGPointMake(pipeTop1.view.center.x - speed, pipeTop1.view.center.y);
    pipeTop2.view.center = CGPointMake(pipeTop2.view.center.x - speed, pipeTop2.view.center.y);
    
    pipeBottom1.view.center = CGPointMake(pipeBottom1.view.center.x - speed, pipeBottom1.view.center.y);
    pipeBottom2.view.center = CGPointMake(pipeBottom2.view.center.x - speed, pipeBottom2.view.center.y);
    
    if (pipeTop1.view.frame.origin.x + pipeTop1.view.bounds.size.width <= 0) {
        pipeTop1.view.center = CGPointMake(pipeTop2.view.center.x + spaceForPipe, [self randomCenterY]);
        resetFramePipe = YES;
    }
    
    if (pipeTop2.view.frame.origin.x + pipeTop2.view.bounds.size.width <= 0) {
        pipeTop2.view.center = CGPointMake(pipeTop1.view.center.x + spaceForPipe, [self randomCenterY]);
        resetFramePipe = YES;
    }
    
    if (pipeBottom1.view.frame.origin.x + pipeBottom1.view.bounds.size.width <= 0) {
        pipeBottom1.view.center = CGPointMake(pipeBottom2.view.center.x + spaceForPipe, pipeTop1.view.center.y + 2*haftPipe + spaceForBirdChange);
    }
    
    if (pipeBottom2.view.frame.origin.x + pipeBottom2.view.bounds.size.width <= 0) {
        pipeBottom2.view.center = CGPointMake(pipeBottom1.view.center.x + spaceForPipe, pipeTop2.view.center.y + 2*haftPipe + spaceForBirdChange);
    }
}

-(void)moveTopAndBottomAtSpeed:(CGFloat)speed
{
    //move top
    top1.view.center = CGPointMake(top1.view.center.x - speed, top1.view.center.y);
    top2.view.center = CGPointMake(top2.view.center.x - speed, top2.view.center.y);
    
    if (top1.view.frame.origin.x + bottomSize.width <= 0) {
        top1.view.frame = CGRectMake(top2.view.frame.origin.x + bottomSize.width, top1.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    if (top2.view.frame.origin.x + bottomSize.width <= 0) {
        top2.view.frame = CGRectMake(top1.view.frame.origin.x + bottomSize.width, top2.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    //move bottom
    bottom1.view.center = CGPointMake(bottom1.view.center.x - speed, bottom1.view.center.y);
    bottom2.view.center = CGPointMake(bottom2.view.center.x - speed, bottom2.view.center.y);
    
    if (bottom1.view.frame.origin.x + bottomSize.width <= 0) {
        bottom1.view.frame = CGRectMake(bottom2.view.frame.origin.x + bottomSize.width, bottom1.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
    
    if (bottom2.view.frame.origin.x + bottomSize.width <= 0) {
        bottom2.view.frame = CGRectMake(bottom1.view.frame.origin.x + bottomSize.width, bottom2.view.frame.origin.y, bottomSize.width, bottomSize.height);
    }
}

-(void)playGame{
    //pipe top
    if (CGRectIntersectsRect(bird.view.frame, pipeTop1.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeTop2.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeBottom1.view.frame) || CGRectIntersectsRect(bird.view.frame, pipeBottom2.view.frame)) {
        self.hit = YES;
        [self gameOver];
        return;
    }
    
    //top
    if (CGRectIntersectsRect(bird.view.frame, top1.view.frame) || CGRectIntersectsRect(bird.view.frame, top2.view.frame)) {
        self.hit = YES;
        [self gameOver];
        return;
    }
    
    if (CGRectIntersectsRect(bird.view.frame, bottom1.view.frame) || CGRectIntersectsRect(bird.view.frame, bottom2.view.frame)) {
        self.hit = NO;
        [self gameOver];
        return;
    }
    
    if (resetFramePipe) {
        if (bird.view.frame.origin.x >= pipeTop1.view.center.x - bird.view.frame.size.width*0.5|| bird.view.frame.origin.x >= pipeTop2.view.center.x - bird.view.frame.size.width*0.5) {
            [bird pointSound];
            [self setScore];
            resetFramePipe = NO;
        }
    }
}

-(void)gameOver{
    [self stopTimer];
    bird.alive = NO;
    [bird animate];
    restart = YES;
}

-(void)gameLoop
{
    [self moveTopAndBottomAtSpeed:birdJumpSpeed];
    [self movePipeAtSpeed:birdJumpSpeed];
    [self playGame];
    
    if (bird.view.center.y >= _height - _bottomHeight - 15) {
        [self gameOver];
    }
    
    [bird animate];
    
}

@end
