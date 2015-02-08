//
//  ProcessData.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "ProcessData.h"
#import "AppDelegate.h"

@implementation ProcessData
{
    NSInteger newSteps;
    float newGoalBar;
    NSArray *newPeriodSteps;
    NSString *newDistance;
    NSString *newWalkingTime;
    
    NSInteger oldSteps;
    float oldGoalBar;
    NSArray *oldPeriodSteps;
    NSString *oldDistance;
    NSString *oldWalkingTime;
}

- (NSString *)todaysDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSLocale *en_US_POSIX = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:en_US_POSIX];
    [formatter setDateFormat:@"EE MMM dd"]; // Thu Oct 24
    
    return [formatter stringFromDate:[NSDate date]];
}

- (NSArray *)processDataWithNewData:(NSArray *)newData andOldData:(NSArray *)oldData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    oldSteps = [[oldData objectAtIndex:0] integerValue];
    oldGoalBar = [[oldData objectAtIndex:1] floatValue];
    oldPeriodSteps = [oldData objectAtIndex:2];
    
    CMPedometerData *newStepData = [newData objectAtIndex:0];
    NSSet *periodData = [newData objectAtIndex:1];
    NSArray *updateTimes = [newData objectAtIndex:2];
    
    // Step count
    newSteps = [newStepData.numberOfSteps integerValue];
    
    // Goal bar
    newGoalBar = (newSteps * 1.0f) / [[NSUserDefaults standardUserDefaults] doubleForKey:dailyGoalPrefsKey];
    
    // Period steps
    newPeriodSteps = [self calcPeriodPercentages:periodData stepCount:newSteps andUpdateTimes:updateTimes];
    
    // Distance
    float unitMultiplier = [[NSUserDefaults standardUserDefaults] floatForKey:selectedUnitPrefsKey];
    if (unitMultiplier == 1.0f)     newDistance = [NSString stringWithFormat:@"%.1f km", newStepData.distance.doubleValue / 1000 * unitMultiplier];
    else                            newDistance = [NSString stringWithFormat:@"%.1f mi", newStepData.distance.doubleValue / 1000 * unitMultiplier];
    
    // Activity time
    float dailyGoalTime = ((float)newSteps / 1200.0f) * 10.0f;
    NSArray *formattedTime = [GlobalModel convertSeconds: dailyGoalTime * 60]; // * 60 to get in seconds
    if ([[formattedTime objectAtIndex:0] intValue] > 0) {
        newWalkingTime = [NSString stringWithFormat:@"%@h %@m", [formattedTime objectAtIndex:0], [formattedTime objectAtIndex:1]];
    } else {
        if ([[formattedTime objectAtIndex:1] integerValue] == 0 && [[formattedTime objectAtIndex:2] integerValue] > 0) {
            newWalkingTime = @"< 1 m";
        } else {
            newWalkingTime = [NSString stringWithFormat:@"%@ m", [formattedTime objectAtIndex:1]];
        }
    }
    
    // Animation duration
    [self setAnimationDurationWithNewSteps: newSteps andOldSteps: oldSteps];
    
    //NSLog(@"process data: %li, %li, %f, %f, %@, %@, %@, %@", oldSteps, newSteps, oldGoalBar, newGoalBar, oldPeriodSteps, newPeriodSteps, newDistance, newWalkingTime);
    
    return @[@(oldSteps), @(newSteps), @(oldGoalBar), @(newGoalBar), oldPeriodSteps, newPeriodSteps, newDistance, newWalkingTime];
}

- (NSArray *)noStepsYet {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    oldSteps = 0;
    oldGoalBar = 0.0f;
    oldPeriodSteps = @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)];
    
    if ([[NSUserDefaults standardUserDefaults] floatForKey:selectedUnitPrefsKey] == 1.0f)   newDistance = @"0 km";
    else                                                                                    newDistance = @"0 mi";
    
    return @[@(0), @(0), @(0.0f), @(0.0f), @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)], @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)], newDistance, @"0 m"];
}

- (NSArray *)calcPeriodPercentages:(NSSet *)periodData stepCount:(NSInteger)stepCount andUpdateTimes:(NSArray *)updateTimes {
    float nightStepPercentage = 0.0f;
    float morningStepPercentage = 0.0f;
    float middayStepPercentage = 0.0f;
    float afternoonStepPercentage = 0.0f;
    float eveningStepPercentage = 0.0f;
    
    for (CMPedometerData *period in periodData) {
        if ([period.startDate isEqualToDate:[updateTimes objectAtIndex:0]]) {
            nightStepPercentage = [period.numberOfSteps floatValue] / stepCount;
        } else if ([period.startDate isEqualToDate:[updateTimes objectAtIndex:1]]) {
            morningStepPercentage = [period.numberOfSteps floatValue] / stepCount;
        } else if ([period.startDate isEqualToDate:[updateTimes objectAtIndex:2]]) {
            middayStepPercentage = [period.numberOfSteps floatValue] / stepCount;
        } else if ([period.startDate isEqualToDate:[updateTimes objectAtIndex:3]]) {
            afternoonStepPercentage = [period.numberOfSteps floatValue] / stepCount;
        } else if ([period.startDate isEqualToDate:[updateTimes objectAtIndex:4]]) {
            eveningStepPercentage = [period.numberOfSteps floatValue] / stepCount;
        }
    }
    return @[@(nightStepPercentage), @(morningStepPercentage), @(middayStepPercentage), @(afternoonStepPercentage), @(eveningStepPercentage)];
}

- (void)setAnimationDurationWithNewSteps:(NSInteger)nSteps andOldSteps:(NSInteger)oSteps {
    
    float diff = (float)oSteps / (float)nSteps;
    
    if (diff < 0.2f)         animationDuration = 1.5f;
    else if (diff < 0.4f)    animationDuration = 2.5f;
    else if (diff < 0.7f)    animationDuration = 3.5f;
    else                     animationDuration = 4.5f;
}

- (void)updateIconBadgeNumber:(NSInteger)stepCount {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:showStepsOnBadgePrefsKey])  [UIApplication sharedApplication].applicationIconBadgeNumber = stepCount;
    else                                                                              [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end
