//
//  GoalTextField.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GoalTextField.h"

@implementation GoalTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.font = [UIFont fontWithName:@"Avenir-Light" size:15.0];
        self.textColor = [UIColor GMDLightText];
        self.textAlignment = NSTextAlignmentLeft;
        self.tintColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1f];
    
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0" attributes:@{
                                                                                                  NSForegroundColorAttributeName: [UIColor colorWithWhite:1.0 alpha:0.3f],
                                                                                                  NSFontAttributeName: self.font
                                                                                                  }];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0));
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
