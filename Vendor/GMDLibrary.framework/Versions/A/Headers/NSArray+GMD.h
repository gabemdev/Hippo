//
//  NSArray+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GMD)
/**
 Provides extensions to `NSArray` for various common tasks.
 */


///------------------------
/// @name Querying an Array
///------------------------

/**
 Returns the object in the array with a random index value.
 
 @return The object in the array with a random index value. If the array is empty, returns `nil`.
 */
- (id)gmd_randomObject;


///--------------------------
/// @name Deriving New Arrays
///--------------------------

/**
 Returns a new array with its elements shuffled.
 
 @return A new array containing the receiving array's elements rearranged in a random order.
 */
- (NSArray *)gmd_shuffledArray;

/**
 Returns the object returned by `mutableCopyWithZone:` where the zone is `nil`.
 
 This differs from `mutableCopy` in that it makes any contained `NSArray` objects or `NSDictionary` objects mutable as
 well. The returned dictionary follows standard memory management conventions for copied objects. You are responsible
 for releasing it.
 
 @return The object returned by the `NSMutableCopying` protocol method `mutableCopyWithZone:`, where the zone is `nil`.
 */
- (NSMutableArray *)gmd_deepMutableCopy NS_RETURNS_RETAINED;

///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD2 digest of the receiver.
 
 @return The string of the MD2 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_MD2Digest;

/**
 Returns a string of the MD4 digest of the receiver.
 
 @return The string of the MD4 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_MD4Digest;

/**
 Returns a string of the MD5 digest of the receiver.
 
 @return The string of the MD5 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_MD5Digest;

/**
 Returns a string of the SHA1 digest of the receiver.
 
 @return The string of the SHA1 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_SHA1Digest;

/**
 Returns a string of the SHA224 digest of the receiver.
 
 @return The string of the SHA224 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_SHA224Digest;

/**
 Returns a string of the SHA256 digest of the receiver.
 
 @return The string of the SHA256 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_SHA256Digest;

/**
 Returns a string of the SHA384 digest of the receiver.
 
 @return The string of the SHA384 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_SHA384Digest;

/**
 Returns a string of the SHA512 digest of the receiver.
 
 @return The string of the SHA512 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 */
- (NSString *)gmd_SHA512Digest;

/**
 *  Get the object at a given index in safe mode (nil if self is empty or out of range)
 *
 *  @param index The index
 *
 *  @return Return the object at a given index in safe mode (nil if self is empty or out of range)
 */
- (instancetype)safeObjectAtIndex:(NSUInteger)index;

/**
 *  Create a reversed array from self
 *
 *  @return Return the reversed array
 */
- (NSArray *)reversedArray;

/**
 *  Convert self to JSON as NSString
 *
 *  @return Return the JSON as NSString or nil if error while parsing
 */
- (NSString *)arrayToJson;

/**
 *  Simulates the array as a circle. When it is out of range, begins again
 *
 *  @param index The index
 *
 *  @return Return the object at a given index
 */
- (instancetype)objectAtCircleIndex:(NSInteger)index;

/**
 *  Create a reversed array from the given array
 *
 *  @param array The array to be converted
 *
 *  @return Return the reversed array
 */
+ (NSString *)arrayToJson:(NSArray *)array;

/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Return the JSON as NSString or nil if error while parsing
 */
+ (NSArray *)reversedArray:(NSArray *)array;


@end


/**
 Provides extensions to `NSMutableArray` for various common tasks.
 */
@interface NSMutableArray (GMD)

///--------------------------
/// @name Changing the Array
///--------------------------

/**
 Shuffles the elements of this array in-place using the Fisher-Yates algorithm.
 */
- (void)gmd_shuffle;

@end
