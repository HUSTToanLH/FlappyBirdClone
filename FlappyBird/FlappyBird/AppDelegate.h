//
//  AppDelegate.h
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainScene.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+(MainScene*)getMainView;
@end

