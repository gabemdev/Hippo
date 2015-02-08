//
//  ViewController.m
//  Goal
//
//  Created by Rockstar. on 1/9/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "ViewController.h"
#import "DTStepModelController.h"
#import "LoginViewController.h"
#import "DataController.h"
#import "UICountingLabel.h"
#import "SettingsController.h"
#import "ShareModel.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UICountingLabel *stepsLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic) UILabel *label;
@property (nonatomic) UIButton *show;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *containerView;

@property (nonatomic, strong) DataController *dataController;
@property (nonatomic, strong) SettingsController *settingsController;
@property (nonatomic, strong) ShareModel *shareModel;
@end

@implementation ViewController {
    DTStepModelController *_stepModel;
}
@synthesize stepsLabel = _stepsLabel;
@synthesize label = _label;
@synthesize show = _show;
@synthesize scrollView =_scrollView;
@synthesize containerView = _containerView;
@synthesize distanceLabel = _distanceLabel;
@synthesize dateLabel = _dateLabel;

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

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.textColor = [UIColor GMDText];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont GMDInterfaceFontOfSize:30];
        _label.text = @"Steps Today";
    }
    return _label;
}


- (UICountingLabel *)stepsLabel {
    if (!_stepsLabel) {
        _stepsLabel = [[UICountingLabel alloc] init];
        _stepsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stepsLabel.format = @"%d";
        _stepsLabel.method = UILabelCountingMethodEaseOut;
        [_stepsLabel countFrom:0 to:0000 withDuration: animationDuration];
        _stepsLabel.textColor = [UIColor GMDBlue];
        _stepsLabel.textAlignment = NSTextAlignmentCenter;
        _stepsLabel.font = [UIFont boldGMDInterfaceFontOfSize:60];
        _stepsLabel.text = @"00000";
    }
    return _stepsLabel;
}

- (UIButton *)show {
    if (!_show) {
        _show = [UIButton initWithFrame:CGRectMake(0, 0, 200, 42) title:@"Logout" color:[UIColor GMDColorWithHex:@"0DE7A4"]];
        _show.translatesAutoresizingMaskIntoConstraints = NO;
        [_show setTitleColor:[UIColor whiteColor]];
        _show.titleLabel.font = [UIFont boldGMDInterfaceFontOfSize:15];
        [_show addTarget:self action:@selector(showView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _show;
}

#pragma mark - UIViewController

- (instancetype)init {
    if ((self = [super init])) {
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Goal";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if ([CMPedometer isStepCountingAvailable])  [self initialize];
    else                                        [self showNotAuthorizedAlert:NO];
    
    _stepModel = [[DTStepModelController alloc] init];
    [_stepModel addObserver:self forKeyPath:@"stepsToday" options:NSKeyValueObservingOptionNew context:NULL];
    [self _updateSteps:_stepModel.stepsToday];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadViews];
    [self setupLayouts];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initialize {
    
    if (debugEnabled) NSLog(@"DEBUG MODE ENABLED");
    
    // Data models
    _dataController = [DataController sharedManager];
    
    // Create KVO
    [_dataController addObserver:self
                      forKeyPath:@"dataUpdated"
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
}

- (void)showView:(id)sender {
    [PFUser logOut];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"email"];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    
    [_dataController decideIfIsUpdateNecessary];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _checkUser];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _checkUser];
}

- (void)_checkUser {
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    }
    return;
}

#pragma mark - Load Views
- (void)loadViews {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more-icon-setting"] style:UIBarButtonItemStylePlain target:self action:@selector(settingsButton:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButton:)];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    
    [self stepsLabel];
    [self.containerView addSubview:self.stepsLabel];
    
    [self label];
    [self.containerView addSubview:self.label];
    
    [self show];
    [self.containerView addSubview:self.show];
    
    [self createGraphView];
    [self createGoalBarView];
    [self createLabels];
}

#pragma mark - Memory Management
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_stepModel removeObserver:self forKeyPath:@"stepsToday"];
}


#pragma mark - Model
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self _updateSteps:_stepModel.stepsToday];
}

- (void)_updateSteps:(NSInteger)steps {
    GMDDispatchOnMain(^{
        if (steps>0) {
//            self.stepsLabel.text = [NSString stringWithFormat:@"%ld", (long)steps];
           [self updateStepLabels:@[@(_dataController.stepsOld), @(_dataController.stepsNew), _dataController.distanceNew, _dataController.walkingTimeNew, [NSString stringWithFormat:@"daily goal: %.0f steps", [[NSUserDefaults standardUserDefaults] doubleForKey:dailyGoalPrefsKey]], _dataController.date]];
            self.stepsLabel.font = [UIFont GMDInterfaceFontOfSize:60];
            self.stepsLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
            [self updateGoalBarWithFromValue:_dataController.goalBarOld andToValue:_dataController.goalBarNew];
            [self updateCircleGraphsWithOldData:_dataController.periodStepsOld andNewData:_dataController.periodStepsNew];
        } else {
            self.stepsLabel.font = [UIFont GMDInterfaceFontOfSize:20];
            self.stepsLabel.text = @"Not Available";
            self.stepsLabel.textColor = [UIColor redColor];
        }
    });
}

#pragma mark - Goal
- (void)createGoalBarView {
    self.goalBarView = [[Goalbar alloc] initWithFrame:CGRectMake(33.0, 400.0, self.view.frame.size.width - 67.0, 42.0)];
    [self.containerView addSubview: _goalBarView];
}

- (void)updateGoalBarWithFromValue:(float)fromValue andToValue:(float)toValue {
    [self.goalBarView updateFillFrom:fromValue to:toValue];
}

- (void)createGraphView {
    float diameter = 50.0;
    self.graphScrollView = [[GraphScrollView alloc] initWithFrame:CGRectMake(0.0, 450.0, self.view.frame.size.width + 5, diameter + 25)];
    [self.containerView addSubview:_graphScrollView];
}

- (void)updateCircleGraphsWithOldData:(NSArray *)oldData andNewData:(NSArray *)newData {
    [self.graphScrollView.circleNight updateFillFrom:[[oldData objectAtIndex:0] floatValue] to:[[newData objectAtIndex:0] floatValue]];
    [self.graphScrollView.circleMorning updateFillFrom:[[oldData objectAtIndex:1] floatValue] to:[[newData objectAtIndex:1] floatValue]];
    [self.graphScrollView.circleMidday updateFillFrom:[[oldData objectAtIndex:2] floatValue] to:[[newData objectAtIndex:2] floatValue]];
    [self.graphScrollView.circleAfternoon updateFillFrom:[[oldData objectAtIndex:3] floatValue] to:[[newData objectAtIndex:3] floatValue]];
    [self.graphScrollView.circleEvening updateFillFrom:[[oldData objectAtIndex:4] floatValue] to:[[newData objectAtIndex:4] floatValue]];
}

- (void)createLabels {
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - (18.0f + 100.0f), self.view.frame.size.height - 150, 100.0f, 30.0f)];
    _distanceLabel.text = @"N/A";
    _distanceLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.font = [UIFont fontWithName:fontMedium size:18.0f];
    [self.containerView addSubview: _distanceLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13.0f, self.view.frame.size.width, 30.0f)];
    _dateLabel.text = @"Today's Date: ";
    _dateLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont fontWithName:fontMedium size:20.0f];
    [self.containerView addSubview: _dateLabel];
}

- (void)updateStepLabels:(NSArray *)texts {
    NSInteger stepFromValue = [[texts objectAtIndex: 0] integerValue];
    NSInteger stepToValue = [[texts objectAtIndex: 1] integerValue];
    [self.stepsLabel countFrom:stepFromValue to:stepToValue withDuration: animationDuration];
    self.distanceLabel.text = [texts objectAtIndex:2];
    self.dateLabel.text = [texts objectAtIndex:5];
}


#pragma mark - Actions
- (void)settingsButton:(id)sender {
    _settingsController = [[SettingsController alloc] initWithNibName:@"SettingsView" bundle:nil];
    
    [self.settingsController showInView:self.view andViewController:self];
}

- (void)shareButton:(id)sender {
    _shareModel = [[ShareModel alloc] init];
    [self presentViewController:[_shareModel getShareView:self.view] animated:YES completion:nil];
}

- (void)showNotAuthorizedAlert:(BOOL)M7Compatible {
    NSString *alertTitle = @"";
    NSString *alertMessage = @"";
    
    if (M7Compatible) {
        alertTitle = @"Whoops!";
        alertMessage =[NSString stringWithFormat:@"%@ needs permission to collect your steps. You can reactivate StepTracker's permission in the privacy menu in Settings.", appName];
    } else {
        alertTitle = @"No iPhone 5s, 6 or 6 Plus?";
        alertMessage = [NSString stringWithFormat:@"%@ uses the build-in M7 processor to track your steps. Unfortunately the app won't work on your device. \nI hope to see you again in the future.", appName];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - AutoLayout

- (void)setupLayouts {
    
    NSDictionary *views = @{
                            @"scrollView" :self.scrollView
                            };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|" options:kNilOptions metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:0.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTop multiplier:1.0 constant:25.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42.0]];
}
@end
