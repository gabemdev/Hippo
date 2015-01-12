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

@interface ViewController ()
@property (nonatomic) UILabel *stepsLabel;
@property (nonatomic) UILabel *label;
@property (nonatomic) UIButton *show;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) UIView *containerView;
@end

@implementation ViewController {
    DTStepModelController *_stepModel;
}
@synthesize stepsLabel = _stepsLabel;
@synthesize label = _label;
@synthesize show = _show;
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



- (UILabel *)stepsLabel {
    if (!_stepsLabel) {
        _stepsLabel = [[UILabel alloc] init];
        _stepsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stepsLabel.textColor = [UIColor GMDBlue];
        _stepsLabel.textAlignment = NSTextAlignmentLeft;
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

- (instancetype)init {
    if ((self = [super init])) {
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Goal";
    
    _stepModel = [[DTStepModelController alloc] init];
    [_stepModel addObserver:self forKeyPath:@"stepsToday" options:NSKeyValueObservingOptionNew context:NULL];
    [self _updateSteps:_stepModel.stepsToday];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadViews];
    [self setupLayouts];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.containerView];
    
    [self stepsLabel];
    [self.containerView addSubview:self.stepsLabel];
    
    
    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.textColor = [UIColor GMDText];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.font = [UIFont GMDInterfaceFontOfSize:30];
    _label.text = @"Steps Today";
    [self.containerView addSubview:self.label];
    
    [self show];
    [self.containerView addSubview:self.show];
}

- (void)dealloc {
    [_stepModel removeObserver:self forKeyPath:@"stepsToday"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self _updateSteps:_stepModel.stepsToday];
}

- (void)_updateSteps:(NSInteger)steps {
    GMDDispatchOnMain(^{
        if (steps>0) {
            self.stepsLabel.text = [NSString stringWithFormat:@"%ld", (long)steps];
            self.stepsLabel.font = [UIFont GMDInterfaceFontOfSize:60];
            self.stepsLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
        } else {
            self.stepsLabel.font = [UIFont GMDInterfaceFontOfSize:20];
            self.stepsLabel.text = @"Not Available";
            self.stepsLabel.textColor = [UIColor redColor];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"email"];
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _checkUser];
}

- (void)viewDidAppear:(BOOL)animated {
    [self _checkUser];
}

- (void)_checkUser {
    NSString *user = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
    NSLog(@"%@", user);
    if (!user) {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    }
    return;
    
    
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
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:0.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:0.0 constant:2.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeft multiplier:0.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeBaseline multiplier:0.0 constant:20.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeWidth multiplier:0.0 constant:200]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.show attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42.0]];
}
@end
