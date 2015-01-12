//
//  NSNumber+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (GMD)
#if __cplusplus
extern "C" {
#endif
    
CGFloat DegreesToRadians(CGFloat degrees);
/**
 *  Radians to degrees conversion
 *
 *  @param radians Radians to be converter
 *
 *  @return Return the convertion result
 */
CGFloat RadiansToDegrees(CGFloat radians);
#if _cplusplus
}
#endif

/**
 *  Create a random integer between the given range
 *
 *  @param minValue Mininum random value
 *  @param maxValue Maxinum random value
 *
 *  @return Return the created random integer
 */
+ (NSInteger)randomIntBetweenMin:(NSInteger)minValue
                          andMax:(NSInteger)maxValue;

/**
 *  Create a random float
 *
 *  @return Return the created random float
 */
+ (CGFloat)randomFloat;

/**
 *  Create a random float between the given range
 *
 *  @param minValue Mininum random value
 *  @param maxValue Maxinum random value
 *
 *  @return Return the created random float
 */
+ (CGFloat)randomFloatBetweenMin:(CGFloat)minValue
                          andMax:(CGFloat)maxValue;

- (NSDate *)gmd_dateValue;
@end
