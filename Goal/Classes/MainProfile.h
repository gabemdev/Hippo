//
//  MainProfile.h
//  Goal
//
//  Created by Rockstar. on 1/12/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProfile : UIView
@property (nonatomic, copy) UIImageView *profileImage;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;
@end
