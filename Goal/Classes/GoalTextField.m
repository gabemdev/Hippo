//
//  GoalTextField.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GoalTextField.h"

@implementation GoalTextField

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.font = [UIFont fontWithName:@"Avenir-Light" size:24.0];
        self.textColor = [UIColor GMDText];
        self.textAlignment = NSTextAlignmentCenter;
        self.tintColor = [UIColor GMDColorWithHex:@"0DE7A4"];
        self.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:0.1f];
        self.layer.cornerRadius = 5.0;
        
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0" attributes:@{
                                                                                                  NSForegroundColorAttributeName: [UIColor colorWithWhite:1.0 alpha:0.3f],
                                                                                                  NSFontAttributeName: self.font
                                                                                                  }];
        
        UILabel *suffix = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 54.0)];
        suffix.text = @"Steps";
        suffix.textColor = [UIColor colorWithWhite:1.0 alpha:0.3f];
        suffix.font = self.font;
        self.rightView = suffix;
        self.rightViewMode = UITextFieldViewModeAlways;
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
