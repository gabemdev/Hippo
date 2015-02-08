//
//  StepView.m
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "StepView.h"
#import "UICountingLabel.h"

@interface StepView()
@property (nonatomic, strong) UICountingLabel *stepsLabel;
@property (nonatomic, strong) UILabel *dailyGoalLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic) UILabel *label;
@end

@implementation StepView
@synthesize stepsLabel = _stepsLabel;
@synthesize label = _label;
@synthesize distanceLabel = _distanceLabel;
@synthesize dateLabel = _dateLabel;

- (UICountingLabel *)stepsLabel {
    if (!_stepsLabel) {
        _stepsLabel = [[UICountingLabel alloc] init];
        _stepsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _stepsLabel.format = @"%d";
        _stepsLabel.method = UILabelCountingMethodEaseOut;
        [_stepsLabel countFrom:0 to:9230 withDuration: animationDuration];
        _stepsLabel.textColor = [UIColor GMDBlue];
        _stepsLabel.textAlignment = NSTextAlignmentCenter;
        _stepsLabel.font = [UIFont boldGMDInterfaceFontOfSize:60];
        _stepsLabel.text = @"00000";
    }
    return _stepsLabel;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createGoalBarView];
        [self createGraphView];
        [self createLabels];
        [self setupConstraints];
    }
    return self;
}

#pragma mark - Graphs
- (void)createGoalBarView {
    self.goalBarView = [[Goalbar alloc] init];
    [self addSubview: _goalBarView];
}

- (void)updateGoalBarWithFromValue:(float)fromValue andToValue:(float)toValue {
    [self.goalBarView updateFillFrom:fromValue to:toValue];
}

- (void)createGraphView {
    float diameter = 50.0;
    self.graphScrollView = [[GraphScrollView alloc] initWithFrame:CGRectMake(0.0, 450.0, self.bounds.size.width + 5, diameter + 25)];
    [self addSubview:_graphScrollView];
}

- (void)updateCircleGraphsWithOldData:(NSArray *)oldData andNewData:(NSArray *)newData {
    [self.graphScrollView.circleNight updateFillFrom:[[oldData objectAtIndex:0] floatValue] to:[[newData objectAtIndex:0] floatValue]];
    [self.graphScrollView.circleMorning updateFillFrom:[[oldData objectAtIndex:1] floatValue] to:[[newData objectAtIndex:1] floatValue]];
    [self.graphScrollView.circleMidday updateFillFrom:[[oldData objectAtIndex:2] floatValue] to:[[newData objectAtIndex:2] floatValue]];
    [self.graphScrollView.circleAfternoon updateFillFrom:[[oldData objectAtIndex:3] floatValue] to:[[newData objectAtIndex:3] floatValue]];
    [self.graphScrollView.circleEvening updateFillFrom:[[oldData objectAtIndex:4] floatValue] to:[[newData objectAtIndex:4] floatValue]];
}

- (void)createLabels {
    [self stepsLabel];
    
    _dailyGoalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 260.0 + 10.0f, self.bounds.size.width, 30.0f)];
    _dailyGoalLabel.text = @"daily goal: 10000 steps";
    _dailyGoalLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    _dailyGoalLabel.textAlignment = NSTextAlignmentCenter;
    _dailyGoalLabel.font = [UIFont fontWithName:@"Avenir-Light" size:17.0f];
    [self addSubview: _dailyGoalLabel];
    
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - (18.0f + 100.0f), self.bounds.size.height - 150, 100.0f, 30.0f)];
    _distanceLabel.text = @"N/A";
    _distanceLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel.font = [UIFont fontWithName:fontMedium size:18.0f];
    [self addSubview: _distanceLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13.0f, self.bounds.size.width, 30.0f)];
    _dateLabel.text = @"Current date:";
    _dateLabel.textColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont fontWithName:fontMedium size:20.0f];
    [self addSubview: _dateLabel];
    
    _label = [[UILabel alloc] init];
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    _label.textColor = [UIColor GMDText];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont GMDInterfaceFontOfSize:30];
    _label.text = @"Steps Today";
    [self addSubview:self.label];
}

- (void)updateStepLabels:(NSArray *)texts {
    NSInteger stepFromValue = [[texts objectAtIndex: 0] integerValue];
    NSInteger stepToValue = [[texts objectAtIndex: 1] integerValue];
    [self.stepsLabel countFrom:stepFromValue to:stepToValue withDuration: animationDuration];
    self.distanceLabel.text = [texts objectAtIndex:2];
    self.dateLabel.text = [texts objectAtIndex:5];
}

#pragma mark - Constraints
- (void)setupConstraints {
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goalBarView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goalBarView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goalBarView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goalBarView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
     
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeBaseline multiplier:0.0 constant:50.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.stepsLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:0.0 constant:30.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.0 constant:42]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0]];

    
}

@end
