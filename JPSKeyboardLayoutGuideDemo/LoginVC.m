//
//  LoginVC.m
//  JPSKeyboardLayoutGuideDemo
//
//  Created by JP Simard on 2014-03-26.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "LoginVC.h"
#import "JPSKeyboardLayoutGuideViewController.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField *loginField;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self jps_viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    
    [self setupLoginField];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self jps_viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self jps_viewDidDisappear:animated];
}

- (void)setupLoginField {
    self.loginField = [[UITextField alloc] init];
    self.loginField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginField];
    self.loginField.placeholder = @"username";
    
    // Constraints
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.loginField
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1.0f
                                                                constant:0.0f];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.loginField
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.keyboardLayoutGuide
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0f
                                                               constant:-100.0f];
    [self.view addConstraints:@[centerX, bottom]];
}

- (void)dismissKeyboard {
    [self.loginField resignFirstResponder];
}

@end
