//
//  GMDUserProfile.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDUserProfile : UIView
@property (nonatomic, copy) UIImageView *profileImage;
@property (nonatomic, copy) UILabel *nameLabel;
@property (nonatomic, copy) UILabel *status;
@property (nonatomic, copy) UILabel *location;

- (CGFloat)verticalSpacing;
- (void)setupViews;
- (void)setupConstraints;

@end
