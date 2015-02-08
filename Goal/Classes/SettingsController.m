//
//  SettingsController.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "SettingsController.h"
#import "DataController.h"
#import "ColorPickerView.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface SettingsController ()

@property (weak, nonatomic) UIView *popUpView;
@property (weak, nonatomic) UIButton *doneButton;
@property (weak, nonatomic) UILabel *staticSettingsLabel;
@property (weak, nonatomic) UILabel *staticStepsLabel;
@property (weak, nonatomic) UILabel *stepsLabel;
@property (weak, nonatomic) UISegmentedControl *unitControl;
@property (weak, nonatomic) UIStepper *goalStepper;
@property (weak, nonatomic) UILabel *staticColorLabel;
@property (weak, nonatomic) UILabel *staticBadgeLabel;
@property (weak, nonatomic) UISwitch *badgeSwitch;
@property (weak, nonatomic) UIButton *mailButton;
@property (strong, nonatomic) UIButton *colorPickerBackButton;
@property (strong, nonatomic) UILabel *chooseColorTitle;

@property (nonatomic, strong) ColorPickerView *colorPickerView;
@property (nonatomic, strong) ViewController *ovc;

@end

@implementation SettingsController
{
    NSUserDefaults *userDefaults;
    
    NSString *font;
    UIColor *backgroundColor;
    UIColor *textColor;
    
    CALayer *navBar;
    
    float unitMultiplier;
    BOOL showBadge;
    double dailyGoal;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
        
        font = @"Avenir-Light";
        backgroundColor = [UIColor GMDColorWithHex: [userDefaults stringForKey:backgroundColorPrefsKey]];
        textColor = [UIColor GMDColorWithHex: [userDefaults stringForKey:textColorPrefsKey]];
        
        _colorUpdated = 0;
        
        self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
        self.popUpView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
        self.popUpView.layer.cornerRadius = 5;
        self.popUpView.layer.shadowOpacity = 0.8;
        self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.popUpView.layer.masksToBounds = YES;
        
        [self loadValues];
        [self setColors];
        [self colorButton];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadValues {
    unitMultiplier = [userDefaults floatForKey:selectedUnitPrefsKey];
    showBadge = [userDefaults boolForKey:showStepsOnBadgePrefsKey];
    dailyGoal = [userDefaults doubleForKey:dailyGoalPrefsKey];
    
    if (unitMultiplier == 1.0)  [_unitControl setSelectedSegmentIndex:1];
    else                        [_unitControl setSelectedSegmentIndex:0];
    
    if (showBadge)              [_badgeSwitch setOn:YES];
    else                        [_badgeSwitch setOn:NO];
    
    // Daily goal
    [_goalStepper setContinuous:YES];
    [_goalStepper setAutorepeat:YES];
    [_goalStepper setStepValue:500];
    [_goalStepper setMinimumValue:2000];
    [_goalStepper setMaximumValue:30000];
    [_goalStepper setValue: dailyGoal];
    _stepsLabel.text = [NSString stringWithFormat:@"%.0f", dailyGoal];
}

- (void)setColors {
    navBar = [CALayer layer];
    navBar.frame = CGRectMake(0, 0, self.popUpView.bounds.size.width, 40.0);
    navBar.backgroundColor = [backgroundColor CGColor];
    [self.popUpView.layer insertSublayer:navBar atIndex:0];
    
    _staticSettingsLabel.textColor = textColor;
    _doneButton.tintColor = textColor;
    _staticStepsLabel.textColor = backgroundColor;
    _stepsLabel.textColor = backgroundColor;
    _goalStepper.tintColor = backgroundColor;
    _unitControl.tintColor = backgroundColor;
    _staticColorLabel.textColor = backgroundColor;
    _staticBadgeLabel.textColor = backgroundColor;
    _badgeSwitch.onTintColor = backgroundColor;
}

- (void)colorButton {
    float circleRadius = 12.0f;
    CALayer *outline = [CALayer layer];
    outline.frame = CGRectMake(self.popUpView.bounds.size.width - 10.0, _staticColorLabel.frame.origin.y, -_unitControl.bounds.size.width / 2, circleRadius * 2);
    outline.cornerRadius = circleRadius;
    outline.borderColor = [backgroundColor CGColor];
    outline.borderWidth = 1.0;
    outline.backgroundColor = nil;
    outline.masksToBounds = YES;
    [self.popUpView.layer addSublayer:outline];
    
    CALayer *bgCircle = [CALayer layer];
    bgCircle.frame = CGRectMake(0.0, 0.0, _unitControl.bounds.size.width / 2, circleRadius * 2);
    bgCircle.cornerRadius = circleRadius;
    bgCircle.backgroundColor = [backgroundColor CGColor];
    [outline addSublayer:bgCircle];
    
    CALayer *tcCircle = [CALayer layer];
    tcCircle.frame = CGRectMake(outline.bounds.size.width, 0.0, -_unitControl.bounds.size.width / 4 - 5, circleRadius * 2);
    tcCircle.cornerRadius = circleRadius;
    tcCircle.backgroundColor = [textColor CGColor];
    [outline addSublayer:tcCircle];
    
    UIButton *colorPickerButton = [[UIButton alloc] initWithFrame:CGRectMake(outline.frame.origin.x, outline.frame.origin.y, outline.bounds.size.width, outline.bounds.size.height)];
    [self.popUpView addSubview:colorPickerButton];
    [colorPickerButton addTarget:self action:@selector(colorPickerAnimateIn) forControlEvents:UIControlEventTouchDown];
}


- (void)goalValueChanged:(UIStepper *)sender {
    dailyGoal = [sender value];
    _stepsLabel.text = [NSString stringWithFormat:@"%.0f", dailyGoal];
}

- (void)unitValueChanged:(UISegmentedControl *)sender {
    switch (_unitControl.selectedSegmentIndex) {
        case 0:
            unitMultiplier = 0.62137f;
            break;
        case 1:
            unitMultiplier = 1.0f;
            break;
        default:
            break;
    }
}

- (void)badgeValueChanged:(UISwitch *)sender {
    if([sender isOn]){
        showBadge = YES;
    } else{
        showBadge = NO;
    }
}

- (void)mailButtonPressed:(UIButton *)sender {
    if([MFMailComposeViewController canSendMail]) {
        
        NSString *emailTitle = appName;
        NSArray *toRecipents = [NSArray arrayWithObject:@"steps@mathiasmortensen.com"];
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setToRecipients:toRecipents];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)doneButtonPressed:(UIButton *)sender {
    // If a value has changed: settingsUpdated is set to TRUE
    if (dailyGoal != [userDefaults doubleForKey:dailyGoalPrefsKey]) {
        [userDefaults setDouble:dailyGoal forKey:dailyGoalPrefsKey];
        
        if (!settingsUpdated)   settingsUpdated = YES;
    }
    if (unitMultiplier != [userDefaults floatForKey:selectedUnitPrefsKey]) {
        [userDefaults setFloat:unitMultiplier forKey:selectedUnitPrefsKey];
        
        if (!settingsUpdated)   settingsUpdated = YES;
    }
    if (showBadge != [userDefaults boolForKey:showStepsOnBadgePrefsKey]) {
        [userDefaults setBool:showBadge forKey:showStepsOnBadgePrefsKey];
        
        if (!settingsUpdated)   settingsUpdated = YES;
    }
    
    // Run update
    [[DataController sharedManager] decideIfIsUpdateNecessary];
    
    [self removeAnimate];
}

- (void)showInView:(UIView *)aView andViewController:(ViewController *)ovc {
    dispatch_async(dispatch_get_main_queue(), ^{
        _ovc = ovc;
        [self addObserver:_ovc forKeyPath:@"colorUpdated" options:NSKeyValueObservingOptionNew context:NULL];
        
        [aView addSubview:self.view];
        [self showAnimate];
    });
}

- (void)showAnimate {
    self.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate {
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

//--------------------------------- Color picker ---------------------------------
- (void)colorPickerAnimateIn {
    [UIView transitionWithView:self.popUpView
                      duration:.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _doneButton.hidden = YES;
                        
                        _colorPickerView = [[ColorPickerView alloc] initWithFrame:CGRectMake(0.0, navBar.bounds.origin.y + navBar.bounds.size.height, self.popUpView.bounds.size.width, self.popUpView.bounds.size.height - navBar.bounds.origin.y)];
                        
                        _staticSettingsLabel.text = @"Background color";
                        
                        _colorPickerBackButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 10.0, 50.0, 20.0)];
                        [_colorPickerBackButton setTitle:@"back" forState:UIControlStateNormal];
                        _colorPickerBackButton.tintColor = textColor;
                        [_colorPickerBackButton addTarget:self action:@selector(colorPickerAnimateOut) forControlEvents:UIControlEventTouchDown];
                        [self.popUpView addSubview:_colorPickerBackButton];
                        
                        [self.popUpView addSubview:_colorPickerView];
                    }
                    completion:NULL];
}

- (void)colorPickerAnimateOut {
    [UIView transitionWithView:self.popUpView
                      duration:.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:^{
                        _doneButton.hidden = NO;
                        _staticSettingsLabel.text = @"Settings";
                        [_colorPickerBackButton removeFromSuperview];
                        
                        [_colorPickerView removeFromSuperview];
                    }
                    completion:NULL];
}

- (void)tilePressed:(id)sender {
    NSLog(@"pressed color: %@", [_colorPickerView.bcColors objectAtIndex:[sender tag]]);
    
    [self updateColorsTo:[_colorPickerView.bcColors objectAtIndex:[sender tag]]];
    [userDefaults setObject:[_colorPickerView.bcColors objectAtIndex:[sender tag]] forKey:backgroundColorPrefsKey];
    self.colorUpdated++;
}

- (void)updateColorsTo:(NSString *)bc {
    navBar.backgroundColor = [[UIColor GMDColorWithHex:bc] CGColor];
    //_staticSettingsLabel.textColor = [UIColor colorWithHexString:tx];
    //_doneButton.tintColor = [UIColor colorWithHexString:tx];
    _staticStepsLabel.textColor = [UIColor GMDColorWithHex:bc];
    _stepsLabel.textColor = [UIColor GMDColorWithHex:bc];
    _goalStepper.tintColor = [UIColor GMDColorWithHex:bc];
    _unitControl.tintColor = [UIColor GMDColorWithHex:bc];
    _staticColorLabel.textColor = [UIColor GMDColorWithHex:bc];
    _staticBadgeLabel.textColor = [UIColor GMDColorWithHex:bc];
    _badgeSwitch.onTintColor = [UIColor GMDColorWithHex:bc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserver:_ovc forKeyPath:@"colorUpdated"];
    _ovc = nil;
}

@end
