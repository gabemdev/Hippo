//
//  GMDFont.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kGMDFontRegularKey;
extern NSString *const kGMDFontItalicKey;
extern NSString *const kGMDFontBoldKey;
extern NSString *const kGMDFontBoldItalicKey;

extern NSString *const kGMDFontExtraBoldKey;
extern NSString *const kGMDFontExtrBoldItalicKey;
extern NSString *const kGMDFontLightKey;
extern NSString *const kGMDFontLightItalicKey;
extern NSString *const kGMDFontSemiboldKey;
extern NSString *const kGMDFontSemiboldItalicKey;

@interface GMDFont : UIFont
#pragma mark - Font Names

+ (NSDictionary *)GMDFontMapForFontKey:(NSString *)key;
+ (NSString *)GMDFontNameForFontKey:(NSString *)key style:(NSString *)style;


#pragma mark - Fonts

+ (UIFont *)GMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)boldItalicGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)italicGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)extraBoldGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)extraBoldItalicGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)lightGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)lightItalicGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)semiboldGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;
+ (UIFont *)semiboldItalicGMDFontOfSize:(CGFloat)fontSize fontKey:(NSString *)key;


#pragma mark - Interface

+ (UIFont *)GMDInterfaceFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldGMDInterfaceFontOfSize:(CGFloat)fontSize;
+ (UIFont *)lightGMDInterfaceFontOfSize:(CGFloat)fontSize;

@end
