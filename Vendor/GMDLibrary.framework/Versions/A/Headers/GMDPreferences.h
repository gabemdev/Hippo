//
//  GMDPreferences.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDPreferences : NSObject

+ (instancetype)sharedPreferences;

- (void)registerDefaults:(NSDictionary *)defaults;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

- (void)synchronize;

@end
