//
//  GoalPreferences.h
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoalPreferences : NSObject

+ (instancetype)sharedPreferences;

- (void)registerDefaults:(NSDictionary *)defaults;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

- (void)synchronize;

@end
