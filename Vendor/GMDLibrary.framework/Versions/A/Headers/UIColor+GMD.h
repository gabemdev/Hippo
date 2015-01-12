//
//  UIColor+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GMD)
+ (UIColor *)GMDBlue;
+ (UIColor *)GMDPurple;
+ (UIColor *)GMDText;
+ (UIColor *)GMDStatic;
+ (UIColor *)GMDDarkText;
+ (UIColor *)GMDOrange;
+ (UIColor *)GMDGreen;
+ (UIColor *)GMDRed;
+ (UIColor *)GMDYellow;
+ (UIColor *)GMDLightText;

+ (UIColor *)GMDCustomWithRed:(CGFloat)r Green:(CGFloat)g Blue:(CGFloat)b andAlpha:(CGFloat)a;

+ (UIColor *)GMDColorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)lightness alpha:(CGFloat)alpha;
+ (UIColor *)GMDColorWithHex:(NSString *)hex;
+ (UIColor *)GMDColorWithCSS:(NSString *)css;
+ (UIColor *)GMDColorWithCSSName:(NSString *)name;
+ (UIColor *)GMDColorWIthRGB:(NSString *)rgb;
+ (UIColor *)GMDColorWithHSL:(NSString *)hsl;
- (instancetype) GMDColorByInterpolatingToColor:(UIColor *)nextColor progress:(CGFloat)progress;

- (NSString *)hexValue;

- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha;

@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat alpha;


/**
 *  Create a random color
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)randomColor;

/**
 *  Create a color from a given color with alpha
 *
 *  @param color UIColor value
 *  @param alpha Alpha value
 *
 *  @return Return the UIColor instance
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                      alpha:(float)alpha;
@end
