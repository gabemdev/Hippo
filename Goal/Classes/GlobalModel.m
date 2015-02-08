//
//  GlobalModel.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GlobalModel.h"

NSString * const appName = @"Steps";

BOOL coreMotionAuthorized = YES;
float animationDuration = 1.5f;
BOOL settingsUpdated = NO;
BOOL debugEnabled = NO; // SET TO YES TO ENABLE DEBUG MODE

NSString *retrivalError = @"";

NSString * const fontRegular = @"Avenir-Light";
NSString * const fontMedium = @"Avenir-Light";;

@implementation GlobalModel
+ (NSArray *)setUpdateTimes {
    
    NSDate *midnight;
    NSDate *morningStart;
    NSDate *middayStart;
    NSDate *afternoonStart;
    NSDate *eveningStart;
    NSDate *dayEnds;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:[NSDate date]];
    
    [comps setHour:0]; // Midnat
    midnight = [calendar dateFromComponents:comps];
    [comps setHour:7]; // Kl 7
    morningStart = [calendar dateFromComponents:comps];
    [comps setHour:11]; // Kl 11
    middayStart = [calendar dateFromComponents:comps];
    [comps setHour:14]; // Kl 14
    afternoonStart = [calendar dateFromComponents:comps];
    [comps setHour:18]; // Kl 18
    eveningStart = [calendar dateFromComponents:comps];
    [comps setHour:24]; // Kl 24
    dayEnds = [calendar dateFromComponents:comps];
    
    return @[midnight, morningStart, middayStart, afternoonStart, eveningStart, dayEnds];
}

+ (BOOL)isDateToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate: [NSDate date]];
    
    NSDate *today = [calendar dateFromComponents:components];
    components = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay fromDate:date];
    
    if([today isEqualToDate:[calendar dateFromComponents:components]]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSArray *)convertSeconds:(float)seconds {
    NSDateComponents* dateCom = [[NSDateComponents alloc] init];
    [dateCom setSecond:seconds];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate* date = [calendar dateFromComponents:dateCom];
    NSDateComponents* result = [calendar components: NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond fromDate:date];
    
    return @[@([result hour]), @([result minute]), @([result second])];
}


@end
