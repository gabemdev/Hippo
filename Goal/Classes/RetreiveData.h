//
//  RetreiveData.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetreiveData : NSObject

typedef void(^TaskCompletion)(BOOL);

@property (nonatomic, strong) CMPedometerData *pedometerDataDay;
@property (nonatomic, strong) NSMutableSet *pedometerDataPeriods;
@property (nonatomic) NSInteger stepsForBadge;

- (void)queryTotalStepsFromMidnight:(NSDate *)midnight andCompletion:(TaskCompletion)queryComplete;
- (void)queryStepsFromTime:(NSDate *)fromTime toTime:(NSDate *)toTime andCompletion:(TaskCompletion)queryComplete;
- (void)backgroundStepQueryFrom:(NSDate *)updateFrom andCompletion:(TaskCompletion) queryCompleted;
- (void)startRealTimeUpdate;

@end
