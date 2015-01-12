//
//  NSUserDefaults+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (GMD)

+ (instancetype)GMDSharedDefaults;
+ (void)gmd_setSignatureSalt:(NSString *)salt;
+ (NSString *)gmd_signatureSalt;

- (id)gmd_signedObjectForKey:(NSString *)defaultName;
- (void)gmd_setSignedObject:(id)value forKey:(NSString *)defaultName;
- (void)gmd_removeSignedObjectForKey:(NSString *)defaultName;

- (NSArray *)gmd_signedArrayForKey:(NSString *)defaultName;
- (NSDictionary *)gmd_signedDictionaryForKey:(NSString *)defaultName;
- (NSData *)gmd_signedDataForKey:(NSString *)defaultName;
- (NSString *)gmd_signedStringForKey:(NSString *)defaultName;
- (NSInteger)gmd_signedIntegerForKey:(NSString *)defaultName;
- (float)gmd_signedFloatForKey:(NSString *)defaultName;
- (double)gmd_signedDoubleForKey:(NSString *)defaultName;
- (BOOL)gmd_signedBoolForKey:(NSString *)defaultName;
- (NSURL *)gmd_signedURLForKey:(NSString *)defaultName;

- (void)gmd_setSignedInteger:(NSInteger)value forKey:(NSString *)defaultName;
- (void)gmd_setSignedFloat:(float)value forKey:(NSString *)defaultName;
- (void)gmd_setSignedDouble:(double)value forKey:(NSString *)defaultName;
- (void)gmd_setSignedBool:(BOOL)value forKey:(NSString *)defaultName;
- (void)gmd_setSignedURL:(NSURL *)url forKey:(NSString *)defaultName;

@end
