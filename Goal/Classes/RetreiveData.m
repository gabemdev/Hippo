//
//  RetreiveData.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "RetreiveData.h"

@interface RetreiveData()
@property (nonatomic, strong) CMPedometer *pedoManager;
@end


@implementation RetreiveData

- (id)init {
    self = [super init];
    if (self) {
        
        _pedoManager = [[CMPedometer alloc] init];
        _pedometerDataDay = [[CMPedometerData alloc] init];
        _pedometerDataPeriods = [[NSMutableSet alloc] init];
        _stepsForBadge = 0;
        
    }
    return self;
}

- (void)queryTotalStepsFromMidnight:(NSDate *)midnight andCompletion:(TaskCompletion)queryComplete {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [_pedoManager queryPedometerDataFromDate:midnight
                                      toDate:[NSDate date]
                                 withHandler:^(CMPedometerData *data, NSError *error) {
                                     if (error) {
                                         NSLog(@"%s: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                         retrivalError = [error localizedDescription];
                                         coreMotionAuthorized = NO;
                                     } else {
                                         self.pedometerDataDay = data;
                                     }
                                     queryComplete(YES);
                                 }];
}


- (void)queryStepsFromTime:(NSDate *)fromTime toTime:(NSDate *)toTime andCompletion:(TaskCompletion)queryComplete {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [_pedoManager queryPedometerDataFromDate:fromTime
                                      toDate:toTime
                                 withHandler:^(CMPedometerData *data, NSError *error) {
                                     if (error) {
                                         NSLog(@"%s: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                         retrivalError = [error localizedDescription];
                                         coreMotionAuthorized = NO;
                                     } else {
                                         [self.pedometerDataPeriods addObject:data];
                                     }
                                     queryComplete(YES);
                                 }];
}

- (void)backgroundStepQueryFrom:(NSDate *)updateFrom andCompletion:(TaskCompletion) queryCompleted {
    
    self.stepsForBadge = 0;
    
    [_pedoManager queryPedometerDataFromDate:updateFrom
                                      toDate:[NSDate date]
                                 withHandler:^(CMPedometerData *data, NSError *error) {
                                     if (error) {
                                         NSLog(@"%s: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                         coreMotionAuthorized = NO;
                                     } else {
                                         self.stepsForBadge = [data.numberOfSteps integerValue];
                                     }
                                     queryCompleted(YES);
                                 }];
}

- (void)startRealTimeUpdate {
    [_pedoManager startPedometerUpdatesFromDate:[NSDate date]
                                    withHandler:^(CMPedometerData *data, NSError *error) {
                                        if (error) {
                                            NSLog(@"%s: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
                                        } else {
                                            NSLog(@"%li", data.numberOfSteps.integerValue);
                                        }
                                    }];
}


@end
