//
//  GoalViewController.m
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GoalViewController.h"
#import "GoalValueView.h"
#import "GoalTextField.h"


@interface GoalViewController () <UITextFieldDelegate>
@property (nonatomic, readonly) GoalTextField *textField;
@property (nonatomic, readonly) UIButton *doneButton;
@property (nonatomic) BOOL controlsHidden;
@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) GoalValueView *valueView;
@property (nonatomic, readonly) NSLayoutConstraint *doneButtonTopConstraint;
@property (nonatomic, readonly) NSLayoutConstraint *textFieldTopConstraint;
@property (nonatomic, readonly) UIView *containerView;

@end

@implementation GoalViewController

#pragma mark - Accessors

@synthesize textField = _textField;
@synthesize controlsHidden = _controlsHidden;
@synthesize doneButton = _doneButton;
@synthesize scrollView = _scrollView;
@synthesize valueView = _valueView;
@synthesize doneButtonTopConstraint = _doneButtonTopConstraint;
@synthesize textFieldTopConstraint = _textFieldTopConstraint;
@synthesize containerView = _containerView;

- (GoalTextField *)textField {
    if (!_textField) {
        _textField = [[GoalTextField alloc] init];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
        _textField.delegate = self;
        _textField.alpha = 0.0;
    }
    return _textField;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] init];
        _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
        _doneButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14.0];
        _doneButton.alpha = 0.0;
        [_doneButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5f] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_doneButton addTarget:self action:@selector(toggleControls:) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        _doneButton.contentEdgeInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        
        _doneButton.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5f].CGColor;
        _doneButton.layer.borderWidth = 1.0;
        _doneButton.layer.cornerRadius = 5.0;
        
    }
    return _doneButton;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.backgroundColor = [UIColor GMDBlue];
    }
    return _containerView;
}

- (GoalValueView *)valueView {
    if (!_valueView) {
        _valueView = [[GoalValueView alloc] init];
        [_valueView.valueButton addTarget:self action:@selector(pickGoal:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _valueView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
