//
//  GlobalModel.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const appName;

extern BOOL coreMotionAuthorized;
extern float animationDuration;
extern BOOL settingsUpdated;
extern BOOL debugEnabled;

extern NSString * const fontRegular;
extern NSString * const fontMedium;
extern NSArray * const bcColors;

extern NSString *retrivalError;

@interface GlobalModel : NSObject
+ (NSArray *)setUpdateTimes;
+ (BOOL)isDateToday:(NSDate *)date;
+ (NSArray *)convertSeconds:(float)seconds;
@end
