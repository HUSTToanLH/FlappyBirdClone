//
//  Bird.h
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Sprite.h"

@interface Bird : Sprite
@property(nonatomic, assign) BOOL alive;
@property(nonatomic, assign) CGFloat y0;
@property(nonatomic, assign) BOOL fly;
@property(nonatomic, strong) NSTimer *birdFallTimer;
-(void)pointSound;
-(void)jump;
@end
