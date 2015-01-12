//
//  LoginViewController.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "SignUpViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;
@property (nonatomic) UILabel *loginLabel;
@property (nonatomic) UIView *separatorView;

@property (nonatomic) UIButton *loginButton;
@property (nonatomic) UIButton *signUpButton;
@property (nonatomic) UIButton *forgotButton;
@property (nonatomic, readonly) UIButton *twitterButton;

@property (nonatomic) UIImageView *headerImageView;
@property (nonatomic) UIImageView *backgroundImageView;

@property (nonatomic, assign) id currentResponder;

@property (nonatomic) UIButton *closeButton;
@property (nonatomic) UIBarButtonItem *close;

@property (nonatomic, readonly) NSLayoutConstraint *emailTopConstraint;

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *containerView;


@end

@implementation LoginViewController {
    BOOL _signUpMode;
}
@synthesize email = _email;
@synthesize password = _password;
@synthesize loginLabel = _loginLabel;
@synthesize loginButton = _loginButton;
@synthesize separatorView = _separatorView;
@synthesize signUpButton = _signUpButton;
@synthesize forgotButton = _forgotButton;
@synthesize headerImageView =  _headerImageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize closeButton = _closeButton;
@synthesize emailTopConstraint = _emailTopConstraint;
@synthesize twitterButton = _twitterButton;
@synthesize scrollView =_scrollView;
@synthesize containerView = _containerView;

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _containerView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"signinHello"];
        _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _headerImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Login" color:[UIColor GMDColorWithHex:@"0DE7A4"]];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        _loginButton.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
        [_loginButton setTitleColor:[UIColor whiteColor]];
        [_loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Sign Up With Email" color:[UIColor GMDColorWithHex:@"3399FF"]];
        _signUpButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_signUpButton setTitleColor:[UIColor whiteColor]];
        _signUpButton.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
        [_signUpButton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpButton;
}

- (UIButton *)twitterButton {
    if (!_twitterButton) {
        _twitterButton = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Sign In with Twitter" color:[UIColor GMDColorWithHex:@"00CCFF"]];
        _twitterButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_twitterButton setTitleColor:[UIColor whiteColor]];
        _twitterButton.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
    }
    return _twitterButton;
}

- (UITextField *)email {
    if (!_email) {
        _email = [[UITextField alloc] init];
        _email.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        _email.translatesAutoresizingMaskIntoConstraints = NO;
        _email.textColor = [UIColor GMDText];
        _email.font = [UIFont GMDInterfaceFontOfSize:16.0];
        _email.placeholder = @"Email";
        _email.borderStyle = UITextBorderStyleNone;
        _email.clearButtonMode = UITextFieldViewModeNever;
        _email.keyboardAppearance = UIKeyboardAppearanceLight;
        _email.keyboardType = UIKeyboardTypeEmailAddress;
        _email.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _email.autocorrectionType = UITextAutocorrectionTypeNo;
        _email.delegate = self;
        _email.returnKeyType = UIReturnKeyNext;
        _email.tintColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
        
    }
    return _email;
}

- (UITextField *)password {
    if (!_password) {
        _password = [[UITextField alloc] init];
        _password.translatesAutoresizingMaskIntoConstraints = NO;
        _password.textColor = [UIColor GMDText];
        _password.font = [UIFont GMDInterfaceFontOfSize:16.0f];
        _password.placeholder = @"Password";
        _password.borderStyle = UITextBorderStyleNone;
        _password.clearButtonMode = UITextFieldViewModeNever;
        _password.keyboardAppearance = UIKeyboardAppearanceLight;
        _password.keyboardType = UIKeyboardTypeDefault;
        _password.secureTextEntry = YES;
        _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _password.delegate = self;
        _password.returnKeyType = UIReturnKeyDone;
        _password.autocorrectionType = UITextAutocorrectionTypeNo;
        _password.tintColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    }
    return _password;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(12, 32, 68, 44);
        _closeButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15];
        [_closeButton setTitleColor:[UIColor redColor]];
        _closeButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [_closeButton setTitle:@"CLOSE" forState:UIControlStateNormal];
        [_closeButton setTitleShadowColor:[UIColor GMDText] forState:UIControlStateNormal];
        [_closeButton setBackgroundColor:[UIColor clearColor]];
    }
    return _closeButton;
}

#pragma mark - Class Methods
+ (CGFloat)textFieldWidth {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 360.0f : 200.0f;
}

- (instancetype)init {
    if ((self = [super init])) {
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Login";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setHidden:NO];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor GMDColorWithHex:@"0DE7A4"];
    
    if (_signUpMode) {
        _signUpMode = NO;
    }
    
    [self loadViews];
    [self setupLayout];
    // Do any additional setup after loading the view.
}


#pragma mark - SetUp Views
- (void)loadViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    
    [self email];
    [self password];
    [self loginButton];
    [self signUpButton];
    [self twitterButton];
    [self headerImageView];
    
    [self.containerView addSubview:self.email];
    [self.containerView addSubview:self.password];
    [self.containerView addSubview:self.loginButton];
    [self.containerView addSubview:self.signUpButton];
    [self.containerView addSubview:self.twitterButton];
    [self.containerView addSubview:self.headerImageView];
    [self.headerImageView setAlpha:0.0];
    
    [self _validateButton];
    
    _separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 2)];
    _separatorView.backgroundColor = [UIColor GMDColorWithHex:@"0DE7A4"];
    _separatorView.alpha = 0.8;
    _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addSubview:self.separatorView];

//    _close = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
//    self.navigationItem.leftBarButtonItem = _close;
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self loadTap];
    
    void (^animations)(void) = ^{
        self.email.alpha = 1.0;
        self.password.alpha = self.email.alpha;
        self.loginButton.hidden = NO;
        self.signUpButton.hidden = self.loginButton.hidden;
        self.twitterButton.hidden = self.loginButton.hidden;
        self.headerImageView.alpha = 1.0;
    };
    [UIView animateWithDuration:0.3 delay:0.0 options:1.0 animations:animations completion:nil];
    [UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0 options:1.0 animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
}

#pragma mark - Validation
- (void)_validateButton {
    BOOL valid = (self.email.text.length > 3) && (self.password.text.length > 6);
    
    if (_signUpMode && valid) {
        //        valid = self.email.text.length >= 5 && self.nameTextField.text.length != 0 && self.lastNameTextField.text.length != 0;
    }
    
    if (valid) {
        [self.loginButton setEnabled:YES];
    } else {
        [self.loginButton setEnabled:NO];
    }
    
}


#pragma mark - TextField
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.currentResponder = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // TODO: Terrible hack #shipit
    dispatch_async(dispatch_get_main_queue(), ^{
        [self _validateButton];
    });
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.email) {
        if (_signUpMode) {
            [self.password becomeFirstResponder];
        } else {
            [self.password becomeFirstResponder];
        }
    }
    else if (textField == self.password) {
        if (_signUpMode) {
            [self.password becomeFirstResponder];
        } else {
            [textField resignFirstResponder];
        }
    }
    return NO;
    
}


#pragma mark - TapRecognizer
- (void)loadTap {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveDetails {
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:email forKey:@"email"];
    [defaults setObject:password forKey:@"password"];
    [defaults synchronize];
}

#pragma mark - Actions
- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login:(id)sender {
    [self saveDetails];
    NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSLog(@"%@", user);
    ViewController *view = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
}

- (void)signup:(id)sender {
    SignUpViewController *view = [[SignUpViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    
}

#pragma mark - Layout
- (void)setupLayout {
    NSDictionary *views = @{
                            @"separator" : self.separatorView,
                            @"scrollView" :self.scrollView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:64]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:320]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:50]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-150.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[separator]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.email attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.separatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.0 constant:2]];
    
    
    
    

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.separatorView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.password attribute:NSLayoutAttributeTop multiplier:1.0 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.loginButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.signUpButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.twitterButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
}

//- (NSLayoutConstraint *)emailTopConstraint {
//    if (!_emailTopConstraint) {
//        _emailTopConstraint = [NSLayoutConstraint constraintWithItem:self.emailTopConstraint attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
//        _emailTopConstraint.priority = UILayoutPriorityDefaultHigh;
//    }
//    return _emailTopConstraint;
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
//    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
//    [self updateConstraints];
//}
//
//- (void)updateConstraints {
//    CGFloat constant = 10.0;
//    
//    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
//        constant += 6.0;
//    }
//    
//}
@end
