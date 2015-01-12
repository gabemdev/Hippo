//
//  GMDrawingUtilities.h
//  GMDLibrary
//
//  Created by Rockstar. on 8/25/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#ifndef GMDRAWINGUTILITIES
#define GMDRAWINGUTILITIES

#define DEGREES_TO_RADIANS(d) ((d) * 0.0174532925199432958f)
#define RADIANS_TO_DEGREES(r) ((r) * 57.29577951308232f)

#endif

/**
 Limits a float to the `min` or `max` value. The float is between `min` and `max` it will be returned unchanged.
 
 @param f The float to limit.
 
 @param min The minumum value for the float.
 
 @param max The minumum value for the float.
 
 @return A float limited to the `min` or `max` value.
 */

extern CGFloat GMFLimit(CGFloat f, CGFloat min, CGFloat max);

///-----------------------------
/// @name Rectangle Manipulation
///-----------------------------

extern CGRect CGRectSetX(CGRect rect, CGFloat x);
extern CGRect CGRectSetY(CGRect rect, CGFloat y);
extern CGRect CGRectSetWidth(CGRect rect, CGFloat width);
extern CGRect CGRectSetHeight(CGRect rect, CGFloat height);
extern CGRect CGRectSetOrigin(CGRect rect, CGPoint origin);
extern CGRect CGRectSetSize(CGRect rect, CGSize size);
extern CGRect CGRectSetZeroOrigin(CGRect rect);
extern CGRect CGRectSetZeroSize(CGRect rect);
extern CGSize CGSizeAspectScaleToSize(CGSize size, CGSize toSize);
extern CGRect CGRectAddPoint(CGRect rect, CGPoint point);


///---------------------------------
/// @name Drawing Rounded Rectangles
///---------------------------------
extern void GMDrawRoundedRect(CGContextRef context, CGRect rect, CGFloat cornerRadius);


///-------------------------
/// @name Creating Gradients
///-------------------------

extern CGGradientRef GMCreateGradientWithColors(NSArray *colors);
extern CGGradientRef GMCreateGradientWithColorsAndLocations(NSArray *colors, NSArray *locations);

///------------------------
/// @name Drawing Gradients
///------------------------

extern void GMDrawGradientInRect(CGContextRef context, CGGradientRef gradient, CGRect rect);