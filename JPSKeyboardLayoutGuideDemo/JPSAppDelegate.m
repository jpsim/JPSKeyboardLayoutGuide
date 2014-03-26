//
//  JPSAppDelegate.m
//  JPSKeyboardLayoutGuideDemo
//
//  Created by JP Simard on 2014-03-26.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSAppDelegate.h"
#import "LoginVC.h"

@implementation JPSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[LoginVC alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
