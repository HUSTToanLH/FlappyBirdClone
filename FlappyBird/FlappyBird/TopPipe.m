//
//  TopPipe.m
//  FlappyBird
//
//  Created by ToanLH on 9/14/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "TopPipe.h"

#define pipeHeight 350
#define pipeWidth 60

@implementation TopPipe

-(instancetype)initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name inScene:scene];
    UIImage *imgPipe = [UIImage imageNamed:@"pipetop.png"];
    
    UIImageView *pipe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pipeWidth, pipeHeight)];
    pipe.image = imgPipe;
    
    self.view = pipe;
    return self;
}

@end
