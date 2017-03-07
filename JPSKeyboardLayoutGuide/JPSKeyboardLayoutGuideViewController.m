//
//  JPSKeyboardLayoutGuideViewController.m
//  JPSKeyboardLayoutGuide
//
//  Created by JP Simard on 2014-03-26.
//  Copyright (c) 2014 JP Simard. All rights reserved.
//

#import "JPSKeyboardLayoutGuideViewController.h"

#import <objc/runtime.h>

@interface UIViewController (JPSKeyboardLayoutGuideViewController_Internal)

@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;

@end

@implementation UIViewController (JPSKeyboardLayoutGuideViewController)

- (void)setBottomConstraint:(NSLayoutConstraint *)bottomConstraint {
    objc_setAssociatedObject(self, @selector(bottomConstraint), bottomConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLayoutConstraint *)bottomConstraint {
    return objc_getAssociatedObject(self, @selector(bottomConstraint));
}

-(void)setKeyboardLayoutGuide:(id<UILayoutSupport>)keyboardLayoutGuide{
    objc_setAssociatedObject(self, @selector(keyboardLayoutGuide), keyboardLayoutGuide, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id<UILayoutSupport>)keyboardLayoutGuide{
    return objc_getAssociatedObject(self, @selector(keyboardLayoutGuide));
}

#pragma mark - View Lifecycle

-(void)_createKeyboardLayoutGuide
{
	self.keyboardLayoutGuide = (id<UILayoutSupport>)[UIView new];
	[(UIView *)self.keyboardLayoutGuide setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self.view addSubview:(UIView *)self.keyboardLayoutGuide];
}

- (void)jps_viewDidLoad {
    [self _createKeyboardLayoutGuide];
    [self setupKeyboardLayoutGuide];
}

- (void)jps_viewWillAppear:(BOOL)animated {
    [self observeKeyboard];
}

- (void)jps_viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard Layout Guide

- (void)setupKeyboardLayoutGuide {
	NSAssert(self.keyboardLayoutGuide, @"keyboardLayoutGuide needs to be created by now");
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
    UIViewAnimationCurve curve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect keyboardFrame = kbFrame.CGRectValue;

    self.bottomConstraint.constant = -keyboardFrame.size.height;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:curve];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    NSTimeInterval animationDuration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    self.bottomConstraint.constant = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:curve];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}

@end
