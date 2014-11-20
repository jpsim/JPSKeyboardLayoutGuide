//
//  JPSKeyboardLayoutGuideViewController.h
//  JPSKeyboardLayoutGuide
//
//  Created by JP Simard on 2014-03-26.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JPSKeyboardLayoutGuideViewController)

- (void)jps_viewDidLoad;
- (void)jps_viewWillAppear:(BOOL)animated;
- (void)jps_viewDidDisappear:(BOOL)animated;

@property (nonatomic, strong) id<UILayoutSupport> keyboardLayoutGuide;

@end
