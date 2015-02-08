//
//  GoalPreferences.m
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GoalPreferences.h"
#import "NSUserDefaults+Goal.h"

@interface GoalPreferences()
@property (nonatomic) NSDictionary *defaults;
@end

@implementation GoalPreferences
#pragma mark - Accessors

@synthesize defaults = _defaults;

- (void)registerDefaults:(NSDictionary *)defaults {
    self.defaults = defaults;
}


- (id)objectForKey:(NSString *)key {
    id value = [[self defaultsStore] objectForKey:key];
    if (!value) {
        value = self.defaults[key];
    }
    return value;
}


- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [[self defaultsStore] setObject:object forKey:key];
    [[self iCloudStore] setObject:object forKey:key];
}


- (void)removeObjectForKey:(NSString *)key {
    [[self defaultsStore] removeObjectForKey:key];
    [[self iCloudStore] removeObjectForKey:key];
}


- (void)synchronize {
    [[self iCloudStore] synchronize];
    [[self defaultsStore] synchronize];
}


#pragma mark - Singleton

+ (instancetype)sharedPreferences {
    static GoalPreferences *preferences;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        preferences = [[self alloc] init];
    });
    return preferences;
}


#pragma mark - NSObject

- (instancetype)init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(iCloudStoreDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:nil];
    }
    return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Private

- (NSUserDefaults *)defaultsStore {
    return [NSUserDefaults gmd_sharedDefaults];
}


- (NSUbiquitousKeyValueStore *)iCloudStore {
    return [NSUbiquitousKeyValueStore defaultStore];
}


- (void)iCloudStoreDidChange:(NSNotification *)notification {
    NSDictionary *iCloud = [[self iCloudStore] dictionaryRepresentation];
    for (NSString *key in iCloud) {
        [[self defaultsStore] setObject:iCloud[key] forKey:key];
    }
}

@end
