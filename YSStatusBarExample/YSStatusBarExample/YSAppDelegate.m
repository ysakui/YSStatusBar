//
//  YSAppDelegate.m
//  YSStatusBarExample
//
//  Created by levi on 2013/10/29.
//  Copyright (c) 2013年 YoshimitsuSakui. All rights reserved.
//

#import "YSAppDelegate.h"
#import "ViewController.h"

@implementation YSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
