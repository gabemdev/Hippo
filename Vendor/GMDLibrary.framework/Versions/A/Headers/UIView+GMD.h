//
//  UIView+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GMD)

//---------------------
// Load view automatically from XIBs
//---------------------

+ (instancetype)loadFromXIB;
+ (instancetype)loadFromXIB: (NSString *)nibName;
+ (instancetype)loadFromXIB: (NSString *)nibName atIndex:(NSUInteger)index;


//--------------------
// Taking Screenshots
//--------------------
- (UIImage *)imageRepresentation;

//--------------------
// Fading In and Out
//--------------------
- (void)hide;
- (void)show;
- (void)fadeOut;
- (void)fadeOutAneRemoveFromSuperView;
- (void)fadeIn;

//-------------------
// Managing the view Hierarchy
//-------------------
- (NSArray *)superviews;
- (instancetype)firstSuperviewOfClass:(Class)superviewClass;

- (CGPoint)trueCenter;
- (void)resetConstraints;

/**
 *  Create an UIView with the given frame and background color
 *
 *  @param frame           UIView's frame
 *  @param backgroundColor UIView's background color
 */
+ (UIView *)initWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor;

/**
 *  Create a border around the UIView
 *
 *  @param color  Border's color
 *  @param radius Border's radius
 *  @param width  Border's width
 */
- (void)createBordersWithColor:(UIColor *)color
              withCornerRadius:(CGFloat)radius
                      andWidth:(CGFloat)width;

/**
 *  Remove the borders around the UIView
 */
- (void)removeBorders;

/**
 *  Create a shadow on the UIView
 *
 *  @param offset  Shadow's offset
 *  @param opacity Shadow's opacity
 *  @param radius  Shadow's radius
 */
- (void)createRectShadowWithOffset:(CGSize)offset
                           opacity:(CGFloat)opacity
                            radius:(CGFloat)radius;

/**
 *  Create a corner radius shadow on the UIView
 *
 *  @param cornerRadius Corner radius value
 *  @param offset       Shadow's offset
 *  @param opacity      Shadow's opacity
 *  @param radius       Shadow's radius
 */
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                          offset:(CGSize)offset
                                         opacity:(CGFloat)opacity
                                          radius:(CGFloat)radius;

/**
 *  Remove the shadow around the UIView
 */
- (void)removeShadow;

/**
 *  Set the corner radius of UIView
 *
 *  @param radius Radius value
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  Create a shake effect on the UIView
 */
- (void)shakeView;

/**
 *  Create a pulse effect on th UIView
 *
 *  @param seconds Seconds of animation
 */
- (void)pulseViewWithTime:(CGFloat)seconds;


@end
