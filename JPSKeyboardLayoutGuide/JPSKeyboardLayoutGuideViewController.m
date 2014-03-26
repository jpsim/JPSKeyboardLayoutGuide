//
//  JPSKeyboardLayoutGuideViewController.m
//  JPSKeyboardLayoutGuide
//
//  Created by JP Simard on 2014-03-26.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSKeyboardLayoutGuideViewController.h"

@interface JPSKeyboardLayoutGuideViewController ()

@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;

@end

@implementation JPSKeyboardLayoutGuideViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupKeyboardLayoutGuide];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self observeKeyboard];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Layout Guide

- (void)setupKeyboardLayoutGuide {
    self.keyboardLayoutGuide = (id<UILayoutSupport>)[UIView new];
    [(UIView *)self.keyboardLayoutGuide setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:(UIView *)self.keyboardLayoutGuide];
    
    // Constraints
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.keyboardLayoutGuide attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.keyboardLayoutGuide attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.keyboardLayoutGuide attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.keyboardLayoutGuide attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
    [self.view addConstraints:@[width, height, centerX, self.bottomConstraint]];
}

#pragma mark - Keyboard Methods

- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSValue *kbFrame = info[UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = kbFrame.CGRectValue;
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    CGFloat height = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;
    
    self.bottomConstraint.constant = -height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.bottomConstraint.constant = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
