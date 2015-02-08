//
//  GraphScrollView.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GraphScrollView.h"

@implementation GraphScrollView

{
    UIColor *_lineColor;
    
    float diameter;
    float xOffset;
    float firstCircleX;
    float secondCircleX;
    float thirdCircleX;
    float fourthCircleX;
    float fifthCircleX;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        diameter = frame.size.height - 25;
        xOffset = 30.0f + diameter;
        
        self.contentSize = CGSizeMake(self.bounds.size.width + xOffset, diameter);
        [self setContentOffset:CGPointMake(xOffset, 0.0)];
        self.canCancelContentTouches = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
        self.scrollEnabled = NO;
        
        firstCircleX = 26.5;
        secondCircleX = firstCircleX + (self.bounds.size.width + diameter) / 5;
        thirdCircleX = secondCircleX + (self.bounds.size.width + diameter) / 5;
        fourthCircleX = thirdCircleX + (self.bounds.size.width + diameter) / 5;
        fifthCircleX = fourthCircleX + (self.bounds.size.width + diameter) / 5;
        
        [self createCircles];
        [self createLabels];
        
        self.changeLabelButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:_changeLabelButton];
    }
    return self;
}

- (void)createCircles {
    self.circleMorning = [[Circle alloc] initWithFrame:CGRectMake(secondCircleX, 0.0, diameter + 2, diameter + 2)];
    self.circleMidday = [[Circle alloc] initWithFrame:CGRectMake(thirdCircleX, 0.0, diameter + 2, diameter + 2)];
    self.circleAfternoon = [[Circle alloc] initWithFrame:CGRectMake(fourthCircleX, 0.0, diameter + 2, diameter + 2)];
    self.circleEvening = [[Circle alloc] initWithFrame:CGRectMake(fifthCircleX, 0.0, diameter + 2, diameter + 2)];
    
    [self addSubview: _circleMorning];
    [self addSubview: _circleMidday];
    [self addSubview: _circleAfternoon];
    [self addSubview: _circleEvening];
}

- (void)createLabels {
    float width = 74.0;
    float height = 25.0;
    float labelOffset = width / 5 - 5;
    float y = diameter + 3;
    
//    _labelNight = [[UILabel alloc] initWithFrame:CGRectMake(firstCircleX - labelOffset, y, width, height)];
//    _labelNight.text = @"Night";
//    _labelNight.textColor = [UIColor GMDText];
//    _labelNight.textAlignment = NSTextAlignmentCenter;
//    _labelNight.font = [UIFont fontWithName:fontRegular size:16.0f];
//    [self addSubview:_labelNight];
    
    _labelMorning = [[UILabel alloc] initWithFrame:CGRectMake(secondCircleX - labelOffset, y, width, height)];
    _labelMorning.text = @"Morning";
    _labelMorning.textColor = [UIColor GMDText];
    _labelMorning.textAlignment = NSTextAlignmentCenter;
    _labelMorning.font = [UIFont GMDInterfaceFontOfSize:16.0f];
    [self addSubview:_labelMorning];
    
    _labelMidday = [[UILabel alloc] initWithFrame:CGRectMake(thirdCircleX - labelOffset, y, width, height)];
    _labelMidday.text = @"Midday";
    _labelMidday.textColor = [UIColor GMDText];
    _labelMidday.textAlignment = NSTextAlignmentCenter;
    _labelMidday.font = [UIFont GMDInterfaceFontOfSize:16.0f];
    [self addSubview:_labelMidday];
    
    _labelAfternoon = [[UILabel alloc] initWithFrame:CGRectMake(fourthCircleX - labelOffset, y, width, height)];
    _labelAfternoon.text = @"Afternoon";
    _labelAfternoon.textColor = [UIColor GMDText];
    _labelAfternoon.textAlignment = NSTextAlignmentCenter;
    _labelAfternoon.font = [UIFont GMDInterfaceFontOfSize:16.0f];
    [self addSubview:_labelAfternoon];
    
    _labelEvening = [[UILabel alloc] initWithFrame:CGRectMake(fifthCircleX - labelOffset, y, width, height)];
    _labelEvening.text = @"Evening";
    _labelEvening.textColor = [UIColor GMDText];
    _labelEvening.textAlignment = NSTextAlignmentCenter;
    _labelEvening.font = [UIFont GMDInterfaceFontOfSize:16.0f];
    [self addSubview:_labelEvening];
}

- (void)updateCircleLabels:(BOOL)isName {
    if (isName) {
        _labelNight.text = @"0-7";
        _labelMorning.text = @"7-11";
        _labelMidday.text = @"11-14";
        _labelAfternoon.text = @"14-18";
        _labelEvening.text = @"18-24";
    } else {
        _labelNight.text = @"Night";
        _labelMorning.text = @"Morning";
        _labelMidday.text = @"Midday";
        _labelAfternoon.text = @"Afternoon";
        _labelEvening.text = @"Evening";
    }
}

- (void)changeLabelColor:(UIColor *)color {
    self.labelNight.textColor = color;
    self.labelMorning.textColor = color;
    self.labelMidday.textColor = color;
    self.labelAfternoon.textColor = color;
    self.labelEvening.textColor = color;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIButton class]] ) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
