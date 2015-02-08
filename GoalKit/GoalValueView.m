//
//  GoalValueView.m
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GoalValueView.h"
#import "GoalDefines.h"
#import "GoalPreferences.h"

@implementation GoalValueView

#pragma mark - Accessors

@synthesize conversionRates = _conversionRates;
@synthesize valueButton = _valueButton;
@synthesize quantityButton = _quantityButton;

- (void)setConversionRates:(NSDictionary *)conversionRates {
    _conversionRates = conversionRates;
    
    static NSNumberFormatter *currencyFormatter = nil;
    static dispatch_once_t currencyOnceToken;
    dispatch_once(&currencyOnceToken, ^{
        currencyFormatter = [[NSNumberFormatter alloc] init];
        currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    });
    
    GoalPreferences *preferences = [GoalPreferences sharedPreferences];
    currencyFormatter.currencyCode = [preferences objectForKey:kGoalSelectedGoalKey];
    double value = [[preferences objectForKey:kGoalNumberOfGoalKey] doubleValue] * [conversionRates[currencyFormatter.currencyCode] doubleValue];
    [self.valueButton setTitle:[currencyFormatter stringFromNumber:@(value)] forState:UIControlStateNormal];
    
    static NSNumberFormatter *numberFormatter = nil;
    static dispatch_once_t numberOnceToken;
    dispatch_once(&numberOnceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
        numberFormatter.currencySymbol = @"";
        numberFormatter.minimumFractionDigits = 0;
        numberFormatter.maximumFractionDigits = 10;
        numberFormatter.roundingMode = NSNumberFormatterRoundDown;
    });
    
    NSNumber *number = [preferences objectForKey:kGoalNumberOfGoalKey];
    
    NSString *title = [numberFormatter stringFromNumber:number];
    [self.quantityButton setTitle:[NSString stringWithFormat:@"%@ Steps", title ? title : @"0"] forState:UIControlStateNormal];
}

- (UIButton *)valueButton {
    if (!_valueButton) {
        _valueButton = [[UIButton alloc] init];
        _valueButton.translatesAutoresizingMaskIntoConstraints = NO;
        _valueButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size: 50.0];
        _valueButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        _valueButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_valueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _valueButton;
}


- (UIButton *)quantityButton {
    if (!_quantityButton) {
        _quantityButton = [[UIButton alloc] init];
        _quantityButton.translatesAutoresizingMaskIntoConstraints = NO;
        _quantityButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size: 20.0];
        [_quantityButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5f] forState:UIControlStateNormal];
    }
    return _quantityButton;
}


#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        
        [self setupViews];
        [self setupConstraints];
    }
    return self;
}


#pragma mark - Configuration

- (CGFloat)verticalSpacing {
    return 16.0;
}


- (void)setupViews {
    [self addSubview:self.valueButton];
    [self addSubview:self.quantityButton];
}


#pragma mark - Private

- (void)setupConstraints {
    NSDictionary *views = @{
                            @"valueButton": self.valueButton,
                            @"quantityView": self.quantityButton
                            };
    
    CGFloat verticalSpacing = [self verticalSpacing];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[valueButton]-|" options:kNilOptions metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.valueButton attribute:NSLayoutAttributeBaseline relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-verticalSpacing]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[quantityView]-|" options:kNilOptions metrics:nil views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.quantityButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.valueButton attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing / 2.0]];
}

@end
