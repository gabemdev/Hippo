//
//  GoalValueView.h
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoalValueView : UIView

@property (nonatomic) NSDictionary *conversionRates;

@property (nonatomic, readonly) UIButton *valueButton;
@property (nonatomic, readonly) UIButton *quantityButton;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;

@end
