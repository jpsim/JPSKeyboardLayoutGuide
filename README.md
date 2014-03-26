# JPSKeyboardLayoutGuide

`JPSKeyboardLayoutGuide` lets you easily make your autolayout view controllers keyboard aware. Think of it as `bottomLayoutGuide`, if it moved along with the keyboard frame.

This makes it dead simple to vertically center items in a view and have them stay centered when the keyboard appears/disappears.

## Installation

### From CocoaPods

Add `pod 'JPSKeyboardLayoutGuide'` to your Podfile.

### Manually

Drag the `JPSKeyboardLayoutGuide` folder into your project.

## Usage

`JPSKeyboardLayoutGuide` is meant to be subclassed by your view controllers that need to respond to the keyboard frame:

```objective-c
@interface LoginVC : JPSKeyboardLayoutGuideViewController
@end

@implementation LoginVC

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
                                                               constant:-10.0f];
    [self.view addConstraints:@[centerX, bottom]];
}


@end
```

In subclasses of `JPSKeyboardLayoutGuide`, you'll see `keyboardLayoutGuide` in addition to `topLayoutGuide` and `bottomLayoutGuide`. All these guides behave in the same way.

For more details on layout guides, refer to Apple's documentation on the [`UILayoutSupport` Protocol](https://developer.apple.com/library/ios/documentation/uikit/reference/UILayoutSupport_Protocol/Reference/Reference.html)

## License

MIT Licensed.
