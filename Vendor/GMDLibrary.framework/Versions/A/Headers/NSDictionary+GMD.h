//
//  NSDictionary+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GMD)
///----------------------------
/// @name Creating Dictionaries
///----------------------------

/**
 Returns a new dictionary that contains a dictionary for a form encoded string.
 
 @param encodedString A string of form encoded compontents.
 
 @return A new dictionary that contains a dictionary for the form encoded string, or `nil` if `encodedString` is an
 invalid representation of a dictionary.
 */
+ (NSDictionary *)gmd_dictionaryWithFormEncodedString:(NSString *)encodedString;


///-------------------------------
/// @name Creating Form Components
///-------------------------------

/**
 Returns a string of form encoded components for using as the query string in a URL.
 
 @return A string of form encoded compontents.
 */
- (NSString *)gmd_stringWithFormEncodedComponents;


///--------------------------
/// @name Deriving New Arrays
///--------------------------

/**
 Returns the object returned by `mutableCopyWithZone:` where the zone is `nil`.
 
 This differs from `mutableCopy` in that it makes any contained `NSArray` objects or `NSDictionary` objects mutable as
 well. The returned dictionary follows standard memory management conventions for copied objects. You are responsible
 for releasing it.
 
 @return The object returned by the `NSMutableCopying` protocol method `mutableCopyWithZone:`, where the zone is `nil`.
 */
- (NSMutableDictionary *)gmd_deepMutableCopy NS_RETURNS_RETAINED;


///--------------
/// @name Hashing
///--------------

/**
 Returns a string of the MD2 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the MD2 digest of the receiver.
 */
- (NSString *)gmd_MD2Digest;

/**
 Returns a string of the MD4 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the MD2 digest of the receiver.
 */
- (NSString *)gmd_MD4Digest;

/**
 Returns a string of the MD5 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the MD5 digest of the receiver.
 */
- (NSString *)gmd_MD5Digest;

/**
 Returns a string of the SHA1 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA1 digest of the receiver.
 */
- (NSString *)gmd_SHA1Digest;

/**
 Returns a string of the SHA224 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA224 digest of the receiver.
 */
- (NSString *)gmd_SHA224Digest;

/**
 Returns a string of the SHA256 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA256 digest of the receiver.
 */
- (NSString *)gmd_SHA256Digest;

/**
 Returns a string of the SHA384 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA384 digest of the receiver.
 */
- (NSString *)gmd_SHA384Digest;

/**
 Returns a string of the SHA512 digest of the receiver.
 
 Internally, `NSPropertyListSerialization` is used to created the hash. Only objects that can be serialized should be
 contained in the receiver when calling this method.
 
 @return The string of the SHA512 digest of the receiver.
 */
- (NSString *)gmd_SHA512Digest;


///------------------------
/// @name Accessing Objects
///------------------------

/**
 Returns the object for the specified key or `nil` if the value is `[NSNull null]`.
 
 @param key The key used to look up the object in the receiver.
 
 @return The object for the specified key or `nil` if the value is `[NSNull null]`.
 */
- (id)gmd_safeObjectForKey:(id)key;

@end
