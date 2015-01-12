//
//  UIImageView+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GMD)

+ (instancetype)initWithImage:(UIImage *)image frame:(CGRect)rect;

+ (instancetype)initWithImage:(UIImage *)image size:(CGSize)size center:(CGPoint)center;

@end
