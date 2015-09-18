//
//  Score.m
//  FlappyBird
//
//  Created by ToanLH on 9/17/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "Score.h"

@implementation Score
{
    CGRect selfFrame;
    CGFloat height;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    height = frame.size.height;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, height);
    return self;
}

- (Score*)getNumber:(int)num
{
    [self removeAllSubviews];
    int unit, tenth, hundred, thousand;
    if (num >= 0) {
        unit = num - 10*(int)(num/10);
    }
    else{
        unit = -1;
    }
    
    if (num >= 10) {
        tenth = (num - 100*(int)(num/100) - unit)/10;
    }
    else{
        tenth = -1;
    }
    
    if (num >= 100) {
        hundred = ((num - 1000*(int)(num/1000)) - (tenth*10+unit))/100;
    }
    else{
        hundred = -1;
    }
    
    if (num >= 1000) {
        thousand = (num - 10000*(int)(num/10000)) - (hundred*100+tenth*10+unit);
    }
    else{
        thousand = -1;
    }
    
    
    if (thousand >= 0) {
        UIImageView *thousandImg = [self getImageNumber:thousand];
        thousandImg.center = CGPointMake(self.bounds.size.width + 2 + thousandImg.bounds.size.width*0.5, height*0.5);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width + 2 + thousandImg.bounds.size.width, height);
        [self addSubview:thousandImg];
    }
    
    if (hundred >= 0) {
        UIImageView *hundredImg = [self getImageNumber:hundred];
        hundredImg.center = CGPointMake(self.bounds.size.width + 2 + hundredImg.bounds.size.width*0.5, height*0.5);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width + 2 + hundredImg.bounds.size.width, height);
        [self addSubview:hundredImg];
    }
    
    if (tenth >= 0) {
        UIImageView *tenthImg = [self getImageNumber:tenth];
        tenthImg.center = CGPointMake(self.bounds.size.width + 2 + tenthImg.bounds.size.width*0.5, height*0.5);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width + 2 + tenthImg.bounds.size.width, height);
        [self addSubview:tenthImg];
    }
    
    if (unit >= 0) {
        UIImageView *unitImg = [self getImageNumber:unit];
        unitImg.center = CGPointMake(self.bounds.size.width + 2 + unitImg.bounds.size.width*0.5, height*0.5);
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width + 2 + unitImg.bounds.size.width, height);
        [self addSubview:unitImg];
    }
    
    return self;
}

-(void)removeAllSubviews{
    for (UIImageView *imgView in [self subviews]) {
        [imgView removeFromSuperview];
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0, height);
}

-(UIImageView*)getImageNumber:(int)number{
    switch (number) {
        case 0:
        {
            UIImage *zeroImg = [UIImage imageNamed:@"numberZero.png"];
            UIImageView *zero = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(zeroImg.size.width/zeroImg.size.height), height)];
            zero.image = zeroImg;
            return zero;
            break;
        }
            
        case 1:
        {
            UIImage *oneImg = [UIImage imageNamed:@"numberOne.png"];
            UIImageView *one = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(oneImg.size.width/oneImg.size.height), height)];
            one.image = oneImg;
            return one;
            break;
        }
            
        case 2:
        {
            UIImage *twoImg = [UIImage imageNamed:@"numberTwo.png"];
            UIImageView *two = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(twoImg.size.width/twoImg.size.height), height)];
            two.image = twoImg;
            return two;
            break;
        }
            
        case 3:
        {
            UIImage *threeImg = [UIImage imageNamed:@"numberThree.png"];
            UIImageView *three = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(threeImg.size.width/threeImg.size.height), height)];
            three.image = threeImg;
            return three;
            break;
        }
            
        case 4:
        {
            UIImage *fourImg = [UIImage imageNamed:@"numberFour.png"];
            UIImageView *four = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(fourImg.size.width/fourImg.size.height), height)];
            four.image = fourImg;
            return four;
            break;
        }
            
        case 5:
        {
            UIImage *fiveImg = [UIImage imageNamed:@"numberFive.png"];
            UIImageView *five = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(fiveImg.size.width/fiveImg.size.height), height)];
            five.image = fiveImg;
            return five;
            break;
        }
            
        case 6:
        {
            UIImage *sixImg = [UIImage imageNamed:@"numberSix.png"];
            UIImageView *six = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(sixImg.size.width/sixImg.size.height), height)];
            six.image = sixImg;
            return six;
            break;
        }
            
        case 7:
        {
            UIImage *sevenImg = [UIImage imageNamed:@"numberSeven.png"];
            UIImageView *seven = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(sevenImg.size.width/sevenImg.size.height), height)];
            seven.image = sevenImg;
            return seven;
            break;
        }
            
        case 8:
        {
            UIImage *eightImg = [UIImage imageNamed:@"numberEight.png"];
            UIImageView *eight = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(eightImg.size.width/eightImg.size.height), height)];
            eight.image = eightImg;
            return eight;
            break;
        }
            
        case 9:
        {
            UIImage *nineImg = [UIImage imageNamed:@"numberNine.png"];
            UIImageView *nine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height*(nineImg.size.width/nineImg.size.height), height)];
            nine.image = nineImg;
            return nine;
            break;
        }
            
        default:
            return nil;
            break;
    }
}

@end
