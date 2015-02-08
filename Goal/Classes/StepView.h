//
//  StepView.h
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphScrollView.h"
#import "Goalbar.h"

@interface StepView : UIView
@property (nonatomic, strong) GraphScrollView *graphScrollView;
@property (nonatomic, strong) Goalbar *goalBarView;

- (void)updateStepLabels:(NSArray *)texts;
- (void)updateGoalBarWithFromValue:(float)fromValue andToValue:(float)toValue;
- (void)updateCircleGraphsWithOldData:(NSArray *)oldData andNewData:(NSArray *)newData;

@end
