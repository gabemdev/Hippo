//
//  GraphScrollView.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Circle.h"

@interface GraphScrollView : UIScrollView
@property (nonatomic, strong) Circle *circleNight;
@property (nonatomic, strong) Circle *circleMorning;
@property (nonatomic, strong) Circle *circleMidday;
@property (nonatomic, strong) Circle *circleAfternoon;
@property (nonatomic, strong) Circle *circleEvening;

@property (nonatomic, strong) UILabel *labelNight;
@property (nonatomic, strong) UILabel *labelMorning;
@property (nonatomic, strong) UILabel *labelMidday;
@property (nonatomic, strong) UILabel *labelAfternoon;
@property (nonatomic, strong) UILabel *labelEvening;

@property (nonatomic, strong) UIButton *changeLabelButton;

- (void)updateCircleLabels:(BOOL)isName;
- (void)changeLabelColor:(UIColor *)color;

@end
