//
//  MainProfile.m
//  Goal
//
//  Created by Rockstar. on 1/12/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "MainProfile.h"

@implementation MainProfile

#pragma mark - Accessors
@synthesize profileImage = _profileImage;


- (UIImageView *)profileImage {
    if (!_profileImage) {
        _profileImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _profileImage.translatesAutoresizingMaskIntoConstraints = NO;
        _profileImage.backgroundColor = [UIColor GMDStatic];
        _profileImage.layer.cornerRadius = 75;
        [_profileImage.layer setBorderColor:[UIColor GMDColorWithHex:@"0DE7A4"].CGColor];
        [_profileImage.layer setBorderWidth:4.0f];
        _profileImage.clipsToBounds = YES;
        _profileImage.image = [UIImage imageNamed:@"signup_camera"];
        _profileImage.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _profileImage;
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
    [self addSubview:self.profileImage];
}

#pragma mark - Private

- (void)setupConstraints {
    NSDictionary *views = @{
                            @"profile" : self.profileImage
                            };
    
    CGFloat verticalSpacing = [self verticalSpacing];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profile(150)]" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[profile(150)]" options:kNilOptions metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.profileImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
}
@end
