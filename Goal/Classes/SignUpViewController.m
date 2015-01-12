//
//  SignUpViewController.m
//  Goal
//
//  Created by Rockstar. on 1/11/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "MainProfile.h"

#define PHOTO_LIBRART_BUTTON_TITLE @"Photo Library"
#define PHOTO_ALBUM_BUTTON_TITLE @"Camera Roll"
#define CAMERA_BUTTON_TITLE @"Camera"
#define CANCEL_BUTTON_TITLE @"Cancel"

@interface SignUpViewController ()<UITextFieldDelegate, UIViewControllerTransitioningDelegate, UIActionSheetDelegate>
@property (nonatomic, readonly) MainProfile *profile;
@property (nonatomic) UITextField *name;
@property (nonatomic) UITextField *lastName;
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;

@property (nonatomic) UIButton *loginButton;
@property (nonatomic) UIButton *signUpButton;

@property (nonatomic) UIImageView *profileImageView;

@property (nonatomic, assign) id currentResponder;

@property (nonatomic, readonly) NSLayoutConstraint *emailTopConstraint;

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *containerView;

@property (nonatomic) UIActionSheet *actionSheet;

@end

@implementation SignUpViewController{
    BOOL _signUpMode;
}

#pragma mark - Accessors
@synthesize profile = _profile;
@synthesize email = _email;
@synthesize password = _password;
@synthesize loginButton = _loginButton;
@synthesize signUpButton = _signUpButton;
@synthesize emailTopConstraint = _emailTopConstraint;
@synthesize scrollView =_scrollView;
@synthesize containerView = _containerView;
@synthesize actionSheet = _actionSheet;

- (MainProfile *)profile {
    if (!_profile) {
        _profile = [[MainProfile alloc] init];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPic:)];
        [singleTap setNumberOfTapsRequired:1];
        [_profile addGestureRecognizer:singleTap];
    }
    return _profile;
}

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

- (UIImageView *)profileImageView {
    if (!_profileImageView) {
        _profileImageView = [[UIImageView alloc] init];
        _profileImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _profileImageView.backgroundColor = [UIColor GMDStatic];
        _profileImageView.layer.cornerRadius = 75;
        _profileImageView.layer.borderColor = [UIColor GMDColorWithHex:@"0DE7A4"].CGColor;
        _profileImageView.layer.borderWidth = 2.0f;
        _profileImageView.clipsToBounds = YES;
        _profileImageView.image = [UIImage imageNamed:@"no-user"];
        [_profileImageView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPic:)];
        [singleTap setNumberOfTapsRequired:1];
        [_profileImageView addGestureRecognizer:singleTap];
    }
    return _profileImageView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Sign Up" color:[UIColor GMDColorWithHex:@"0DE7A4"]];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        _loginButton.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
        [_loginButton setTitleColor:[UIColor whiteColor]];
        [_loginButton addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (UIButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Login instead" color:[UIColor GMDColorWithHex:@"3399FF"]];
        _signUpButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_signUpButton setTitleColor:[UIColor whiteColor]];
        _signUpButton.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
        [_signUpButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signUpButton;
}

- (UITextField *)name {
    if (!_name) {
        _name = [[UITextField alloc] init];
        _name.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:0.1f];
        _name.translatesAutoresizingMaskIntoConstraints = NO;
        _name.textColor = [UIColor GMDText];
        _name.font = [UIFont GMDInterfaceFontOfSize:16.0];
        _name.placeholder = @"First Name";
        _name.borderStyle = UITextBorderStyleNone;
        _name.clearButtonMode = UITextFieldViewModeNever;
        _name.keyboardAppearance = UIKeyboardAppearanceLight;
        _name.keyboardType = UIKeyboardTypeDefault;
        _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _name.delegate = self;
        _name.autocorrectionType = UITextAutocorrectionTypeNo;
        _name.returnKeyType = UIReturnKeyNext;
        _name.tintColor = [UIColor GMDColorWithHex:@"0DE7A4"];

    }
    return _name;
}

- (UITextField *)lastName {
    if (!_lastName) {
        _lastName = [[UITextField alloc] init];
        _lastName.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:0.1f];
        _lastName.translatesAutoresizingMaskIntoConstraints = NO;
        _lastName.textColor = [UIColor GMDText];
        _lastName.font = [UIFont GMDInterfaceFontOfSize:16.0];
        _lastName.placeholder = @"Last Name";
        _lastName.borderStyle = UITextBorderStyleNone;
        _lastName.clearButtonMode = UITextFieldViewModeNever;
        _lastName.keyboardAppearance = UIKeyboardAppearanceLight;
        _lastName.keyboardType = UIKeyboardTypeDefault;
        _lastName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _lastName.delegate = self;
        _lastName.autocorrectionType = UITextAutocorrectionTypeNo;
        _lastName.returnKeyType = UIReturnKeyNext;
        _lastName.tintColor = [UIColor GMDColorWithHex:@"0DE7A4"];
        
    }
    return _lastName;
}

- (UITextField *)email {
    if (!_email) {
        _email = [[UITextField alloc] init];
        _email.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:0.1f];
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
        _password.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:0.1f];
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
    self.title = @"Sign Up";
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setHidden:NO];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.barTintColor = [UIColor GMDColorWithHex:@"0DE7A4"];
    
    if (_signUpMode) {
        _signUpMode = YES;
    }
    
    [self loadViews];
    [self setupLayout];
    
    if (!_profileImageView.image) {
        [_profileImageView setImage:[UIImage imageNamed:@"no-user"]];
    }
    // Do any additional setup after loading the view.
}


#pragma mark - SetUp Views
- (void)loadViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    
    [self name];
    [self lastName];
    [self email];
    [self password];
    [self loginButton];
    [self signUpButton];
//    [self profileImageView];
    
    [self.containerView addSubview:self.name];
    [self.containerView addSubview:self.lastName];
    [self.containerView addSubview:self.email];
    [self.containerView addSubview:self.password];
    [self.containerView addSubview:self.loginButton];
    [self.containerView addSubview:self.signUpButton];
    [self.containerView addSubview:self.profile];
    [self.profile setAlpha:0.0];
    
    [self _validateButton];
    
    //    _close = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    //    self.navigationItem.leftBarButtonItem = _close;
    //    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self loadTap];
    
    void (^animations)(void) = ^{
        self.name.alpha = 1.0;
        self.lastName.alpha = self.name.alpha;
        self.email.alpha = self.name.alpha;
        self.password.alpha = self.email.alpha;
        self.loginButton.hidden = NO;
        self.signUpButton.hidden = self.loginButton.hidden;
        self.profile.alpha = 1.0;
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
        valid = self.email.text.length >= 5 && self.name.text.length != 0 && self.lastName.text.length != 0 && self.password.text.length > 6;
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
    if (textField == self.name) {
        if (_signUpMode) {
            [self.lastName becomeFirstResponder];
        } else {
            [self.lastName becomeFirstResponder];
        }
    }
    else if (textField == self.lastName) {
        if (_signUpMode) {
            [self.email becomeFirstResponder];
        } else {
            [self.email becomeFirstResponder];
        }
    } else if (textField == self.email) {
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
    NSString *name = self.name.text;
    NSString *lastName = self.lastName.text;
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    UIImage *image = self.image;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:@"name"];
    [defaults setObject:lastName forKey:@"lastName"];
    [defaults setObject:email forKey:@"email"];
    [defaults setObject:password forKey:@"password"];
    [defaults setObject:image forKey:@"profile"];
    [defaults synchronize];
}

#pragma mark - Actions
- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)login:(id)sender {
    LoginViewController *view = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
}

- (void)signup:(id)sender {
    NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSLog(@"%@", user);
    [self saveDetails];
    
}

- (void)selectPic:(id)sender {
    if(!self.actionSheet){
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"Choose Source of Image"
                                                                delegate:self cancelButtonTitle:nil
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:nil];
        
        // only add avaliable source to actionsheet
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            [_actionSheet addButtonWithTitle:PHOTO_LIBRART_BUTTON_TITLE];
        }
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            [_actionSheet addButtonWithTitle:PHOTO_ALBUM_BUTTON_TITLE];
        }
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [_actionSheet addButtonWithTitle:CAMERA_BUTTON_TITLE];
        }
        
        [_actionSheet addButtonWithTitle:CANCEL_BUTTON_TITLE];
        [_actionSheet setCancelButtonIndex:_actionSheet.numberOfButtons-1];
        [_actionSheet showFromBarButtonItem:sender animated:YES];
        self.actionSheet = _actionSheet;
    }
    
}

- (void)updateProfilePic {
    NSData *fileData;
    NSString *fileName;
    NSString *fileType;
    
    UIImage *new = self.image;
    fileData = UIImagePNGRepresentation(new);
    fileName = @"image.png";
    fileType = @"image";
    [self.profileImageView setImage:new];
}

#pragma mark - Layout
- (void)setupLayout {
    NSDictionary *views = @{
                            @"scrollView" :self.scrollView,
                            @"container" : self.containerView,
                            @"profile" : self.profile
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profile attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:150]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:150]];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0 constant:20]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.name attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.profile attribute:NSLayoutAttributeBottom multiplier:1.0 constant:80.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.name attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.name attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.name attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.name attribute:NSLayoutAttributeBottom multiplier:1.0 constant:45.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.lastName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lastName attribute:NSLayoutAttributeTop multiplier:1.0 constant:45]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.email attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.email attribute:NSLayoutAttributeTop multiplier:1.0 constant:45]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.password attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.password attribute:NSLayoutAttributeTop multiplier:1.0 constant:70]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.loginButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:50]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:250]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.signUpButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
}

#pragma mark - Image Picker Controller Delegate

-(void)createMaskForImage:(UIImageView *)image
{
    CALayer *mask = [CALayer layer];
    UIImage *maskImage = [UIImage imageNamed:@"circle.png"];
    mask.contents = (id)[maskImage CGImage];
    mask.frame = CGRectMake(0, 0,maskImage.size.width, maskImage.size.height);
    image.layer.mask = mask;
    image.layer.masksToBounds = YES;
}

- (void) displayPickedMedia:(NSDictionary *)info{
    self.image = nil;
    if([info[UIImagePickerControllerMediaType]isEqualToString:(NSString *) kUTTypeImage]){
        UIImage *pickedImage = info[UIImagePickerControllerEditedImage];
        if(!pickedImage){
            pickedImage = info[UIImagePickerControllerOriginalImage];
        }
        if(pickedImage) {
            self.image = pickedImage;
            self.profile.profileImage.image = pickedImage;
//            [self createMaskForImage:self.profileImageView];
            [self resizeImage:pickedImage toWidth:320 andHeight:480];
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        [self displayPickedMedia:info];
    }];
}

#pragma mark - Action Sheet
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    _actionSheet = nil;
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == self.actionSheet.destructiveButtonIndex){
        NSLog(@"destuctivebutton clicked");
    }else if(buttonIndex == self.actionSheet.cancelButtonIndex){
        NSLog(@"cancel clicked");
    }else{
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        self.imagePicker.allowsEditing = NO;
        self.imagePicker.navigationBar.barStyle = UIBarStyleBlack;
        [self.imagePicker.navigationBar setTranslucent:NO];
        self.imagePicker.navigationBar.tintColor = [UIColor whiteColor];
        self.imagePicker.mediaTypes = @[(NSString *) kUTTypeImage]; // choose both video and image
        //picker.mediaTypes = @[(NSString *) kUTTypeImage]; // image only which is default
        NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
        if([choice isEqualToString:PHOTO_LIBRART_BUTTON_TITLE]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else if([choice isEqualToString:PHOTO_ALBUM_BUTTON_TITLE]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else if([choice isEqualToString:CAMERA_BUTTON_TITLE]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentViewController:self.imagePicker animated:YES completion:^{
            NSLog(@"complete picked image");
            self.imagePicker.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        }];
        
    }
}

-(UIImage*)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height {
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [self.image drawInRect:newRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
    
    
}

@end
