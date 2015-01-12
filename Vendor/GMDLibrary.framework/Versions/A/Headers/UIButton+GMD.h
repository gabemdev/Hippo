//
//  UIButton+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+GMD.h"

#define GMDCornerRadius 3.0f
#define GMDOutlineWhite 1.0f
#define GMDOutlineAlpha 0.5f
#define GMDShadowOffset CGSizeMake(0.0f, 1.0f)
#define GMDEdgeInsets UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f)
#define GMDLabelFontSize 14.0f
#define GMDLabelFont @"Avenir-Light"

@interface UIButton (GMD)

+ (UIButton *)GMDBlueButton;
+ (UIButton *)GMDOrangeButton;
+ (UIButton *)GMDGrayButton;
+ (UIButton *)GMDOutlineButton;
+ (UIButton *)GMDRedButton;


+ (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage;
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage;

+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color;
+ (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

+ (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
+ (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

+ (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image;
+ (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

- (void)setTitleFont:(UIFont *)fontName size:(CGFloat)size;
- (void)setTitleColor:(UIColor *)color;
- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;


@end
