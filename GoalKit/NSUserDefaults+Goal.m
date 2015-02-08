//
//  NSUserDefaults+Goal.m
//  Goal
//
//  Created by Rockstar. on 1/16/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "NSUserDefaults+Goal.h"

@implementation NSUserDefaults (Goal)

+ (instancetype)gmd_sharedDefaults {
    static NSUserDefaults *defaults;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaults = [[self alloc] initWithSuiteName:@"group.com.gabemdev.hippo"];
    });
    return defaults;
}

@end
