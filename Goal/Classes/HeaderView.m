//
//  HeaderView.m
//  Goal
//
//  Created by Rockstar. on 1/14/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

#pragma mark - Accessors
@synthesize headerImage = _headerImage;

- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc] initWithImage:[UIImage new]];
        _headerImage.translatesAutoresizingMaskIntoConstraints = NO;
        _headerImage.backgroundColor = [UIColor GMDStatic];
        _headerImage.clipsToBounds = YES;
        _headerImage.image = [UIImage imageNamed:@"signinHello"];
    }
    return _headerImage;
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
    [self addSubview:self.headerImage];
}

#pragma mark - Private

- (void)setupConstraints {
    NSDictionary *views = @{
                            @"header" : self.headerImage
                            };
    
    CGFloat verticalSpacing = [self verticalSpacing];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[header(320)]" options:kNilOptions metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[header(64)]" options:kNilOptions metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImage attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:verticalSpacing]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
}

@end
