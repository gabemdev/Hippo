//
//  GMDColor.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/31/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDColor : UIColor

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

+ (UIColor *)colorWithHex:(NSString *)hex;

- (NSString *)hexValue;

- (NSString *)hexValueWithAlpha:(BOOL)includeAlpha;

@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat alpha;

@end
