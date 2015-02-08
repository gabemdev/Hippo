//
//  HeaderView.h
//  Goal
//
//  Created by Rockstar. on 1/14/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
@property (nonatomic, copy) UIImageView *headerImage;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;

@end
