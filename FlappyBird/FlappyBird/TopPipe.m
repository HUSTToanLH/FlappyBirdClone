//
//  TopPipe.m
//  FlappyBird
//
//  Created by ToanLH on 9/14/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "TopPipe.h"

@implementation TopPipe

-(instancetype)initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name inScene:scene];
    UIImage *imgPipe = [UIImage imageNamed:@"pipetop.png"];
    
    UIImageView *pipe = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [Sprite width], [Sprite height])];
    pipe.image = imgPipe;
    
    self.view = pipe;
    return self;
}

@end
