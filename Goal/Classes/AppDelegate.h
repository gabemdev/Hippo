//
//  AppDelegate.h
//  Goal
//
//  Created by Rockstar. on 1/9/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const dailyGoalPrefsKey;
extern NSString * const selectedUnitPrefsKey;
extern NSString * const showStepsOnBadgePrefsKey;
extern NSString * const backgroundColorPrefsKey;
extern NSString * const textColorPrefsKey;

extern NSString * const oldStepCountPrefsKey;
extern NSString * const oldGoalBarCountPrefsKey;
extern NSString * const oldPeriodStepsCountPrefsKey;
extern NSString * const oldDistancePrefsKey;
extern NSString * const oldWalkingTimePrefsKey;
extern NSString * const lastUpdatePrefsKey;

extern NSArray *loadedData;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

