# JPSKeyboardLayoutGuide

`JPSKeyboardLayoutGuide` lets you easily make your autolayout view controllers keyboard aware. Think of it as `bottomLayoutGuide`, if it moved along with the keyboard frame.

This makes it dead simple to vertically center items in a view and have them stay centered when the keyboard appears/disappears.

## Installation

### From CocoaPods

Add `pod 'JPSKeyboardLayoutGuide'` to your Podfile.

### Manually

Drag the `JPSKeyboardLayoutGuide` folder into your project.

## Usage

`JPSKeyboardLayoutGuide` is a category of `UIViewController`, so for any controller where you want to adopt the behaviour previously described, you must override and call these methods in it's respective callbacks:

```objective-c
- (void)jps_viewDidLoad;
- (void)jps_viewWillAppear:(BOOL)animated;
- (void)jps_viewDidDisappear:(BOOL)animated;

```

A sample implementation would be like this:

```objective-c
#import "JPSKeyboardLayoutGuideViewController.h"

@interface LoginVC : UIViewController
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jps_viewDidLoad];    
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
                                                               constant:-10.0f];
    [self.view addConstraints:@[centerX, bottom]];
}


@end
```

When importing `JPSKeyboardLayoutGuide`, you'll see `keyboardLayoutGuide` in addition to `topLayoutGuide` and `bottomLayoutGuide`. All these guides behave in the same way.

For more details on layout guides, refer to Apple's documentation on the [`UILayoutSupport` Protocol](https://developer.apple.com/library/ios/documentation/uikit/reference/UILayoutSupport_Protocol/Reference/Reference.html)

## License

MIT Licensed.
