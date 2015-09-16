//
//  AppDelegate.m
//  FlappyBird
//
//  Created by ToanLH on 9/12/15.
//  Copyright (c) 2015 ToanLH. All rights reserved.
//

#import "AppDelegate.h"
#import "MainScene.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainScene *mainScene = [[MainScene alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScene];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}

+(MainScene *)getMainView{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIViewController *main = app.window.rootViewController;
    if ([main isKindOfClass:[MainScene class]]) {
        return (MainScene*)main;
    }
    else{
        return nil;
    }
}

@end
