//
//  DataController.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DataController.h"
#import "ProcessData.h"
#import "RetreiveData.h"

@interface DataController ()
@property (nonatomic, strong) ProcessData *processingModel;
@property (nonatomic, strong) RetreiveData *retrievingModel;
@end

@implementation DataController
{
    NSArray *updateTimes;
    NSDate *lastUpdate;
    BOOL lastUpdateWasToday;
}

+ (id)sharedManager {
    static DataController *sharedDataController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataController = [[self alloc] init];
    });
    return sharedDataController;
}

- (id)init {
    self = [super init];
    if (self) {
        _retrievingModel = [[RetreiveData alloc] init];
        _processingModel = [[ProcessData alloc] init];
        
        lastUpdateWasToday = NO;
        
        // Notification center
        NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
        [noteCenter addObserverForName:@"UIApplicationWillEnterForegroundNotification"
                                object:nil
                                 queue:[NSOperationQueue mainQueue]
                            usingBlock:^(NSNotification *notification)
         {
             [self decideIfIsUpdateNecessary];
         }];
        
        [noteCenter addObserverForName:@"UIApplicationSignificantTimeChangeNotification"
                                object:nil
                                 queue:[NSOperationQueue mainQueue]
                            usingBlock:^(NSNotification *notification)
         {
             [self decideIfIsUpdateNecessary];
         }];
        
        
        _stepsNew = 0;
        _goalBarNew = 0.0f;
        _periodStepsNew = @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)];
        _distanceNew = @"0 km";
        _walkingTimeNew = @"0 m";
        
        // Update
        [self decideIfIsUpdateNecessary];
        
    }
    return self;
}

- (void)setOldValues {
    _stepsOld = [[NSUserDefaults standardUserDefaults] integerForKey:oldStepCountPrefsKey];
    _goalBarOld = [[NSUserDefaults standardUserDefaults] floatForKey:oldGoalBarCountPrefsKey];
    _periodStepsOld = [[NSUserDefaults standardUserDefaults] objectForKey:oldPeriodStepsCountPrefsKey];
    _distanceOld = [[NSUserDefaults standardUserDefaults] objectForKey:oldDistancePrefsKey];
    _walkingTimeOld = [[NSUserDefaults standardUserDefaults] objectForKey:oldWalkingTimePrefsKey];
}

- (void)decideIfIsUpdateNecessary {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    lastUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:lastUpdatePrefsKey];
    updateTimes = [GlobalModel setUpdateTimes];
    
    // Check if lastUpdate is equal to today's date
    if ([GlobalModel isDateToday: lastUpdate]) {
        lastUpdateWasToday = YES;
        [self setOldValues];
    } else {
        lastUpdateWasToday = NO;
        [self newDay];
        lastUpdate = [NSDate date];
    }
    
    self.date = [_processingModel todaysDate];
    [_retrievingModel queryTotalStepsFromMidnight: [updateTimes objectAtIndex:0]
                                    andCompletion: ^(BOOL finished) {
                                        
                                        if (finished) {
                                            
                                            NSInteger rawSteps = [_retrievingModel.pedometerDataDay.numberOfSteps integerValue];
                                            
                                            [_processingModel updateIconBadgeNumber: rawSteps];
                                            
                                            if (rawSteps > 0) {
                                                
                                                if (lastUpdateWasToday) {
                                                    
                                                    if (rawSteps > _stepsOld || settingsUpdated) {
                                                        
                                                        settingsUpdated = NO;
                                                        
                                                        [self updateData:^(BOOL finished) {
                                                            
                                                            NSArray *newProcessedData = [_processingModel processDataWithNewData:@[_retrievingModel.pedometerDataDay, _retrievingModel.pedometerDataPeriods, updateTimes] andOldData:@[@(_stepsOld), @(_goalBarOld), _periodStepsOld]];
                                                            
                                                            [self assembleNewData:newProcessedData];
                                                            [_retrievingModel startRealTimeUpdate];
                                                        }];
                                                    }
                                                    
                                                    else {
                                                        [self updateFromOldData];
                                                        [_retrievingModel startRealTimeUpdate];
                                                    }
                                                }
                                                
                                                else {
                                                    
                                                    [self updateData:^(BOOL finished) {
                                                        
                                                        NSArray *newProcessedData = [_processingModel processDataWithNewData:@[_retrievingModel.pedometerDataDay, _retrievingModel.pedometerDataPeriods, updateTimes] andOldData:@[@(_stepsOld), @(_goalBarOld), _periodStepsOld]];
                                                        
                                                        [self assembleNewData:newProcessedData];
                                                        [_retrievingModel startRealTimeUpdate];
                                                    }];
                                                }
                                            }
                                            
                                            else {
                                                [self assembleNewData: [_processingModel noStepsYet]];
                                                [_retrievingModel startRealTimeUpdate];
                                            }
                                        }
                                    }];
}


- (void)updateData:(TaskCompletion) updateComplete {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    [_retrievingModel.pedometerDataPeriods removeAllObjects];
    
    // Steps
    NSArray *updateIntervals = @[@[[updateTimes objectAtIndex:0], [updateTimes objectAtIndex:1]], @[[updateTimes objectAtIndex:1], [updateTimes objectAtIndex:2]], @[[updateTimes objectAtIndex:2], [updateTimes objectAtIndex:3]], @[[updateTimes objectAtIndex:3], [updateTimes objectAtIndex:4]], @[[updateTimes objectAtIndex:4], [updateTimes objectAtIndex:5]]];
    
    NSLog(@"%@", updateIntervals);
    
    __block int completedQueries = 0;
    
    for (int i = 0; i < 5; i++) {
        
        [_retrievingModel queryStepsFromTime: [[updateIntervals objectAtIndex:i] objectAtIndex:0]
                                      toTime: [[updateIntervals objectAtIndex:i] objectAtIndex:1]
                               andCompletion: ^(BOOL finished) {
                                   
                                   if (finished) {
                                       completedQueries++;
                                       
                                       if (completedQueries == 5)       updateComplete(YES);
                                       
                                   }
                               }];
    }
}

- (void)assembleNewData:(NSArray *)newData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    //NSLog(@"newData count = %lu", [newData count]);
    
    if ([newData count] == 5) {
        self.stepsOld = [[newData objectAtIndex:0] integerValue];
        self.stepsNew = [[newData objectAtIndex:0] integerValue];
        self.goalBarOld = [[newData objectAtIndex:1] floatValue];
        self.goalBarNew = [[newData objectAtIndex:1] floatValue];
        self.periodStepsOld = [newData objectAtIndex:2];
        self.periodStepsNew = [newData objectAtIndex:2];
        self.distanceNew = [newData objectAtIndex:3];
        self.walkingTimeNew = [newData objectAtIndex:4];
    }
    
    else if ([newData count] == 8) {
        self.stepsOld = [[newData objectAtIndex:0] integerValue];
        self.stepsNew = [[newData objectAtIndex:1] integerValue];
        self.goalBarOld = [[newData objectAtIndex:2] floatValue];
        self.goalBarNew = [[newData objectAtIndex:3] floatValue];
        self.periodStepsOld = [newData objectAtIndex:4];
        self.periodStepsNew = [newData objectAtIndex:5];
        self.distanceNew = [newData objectAtIndex:6];
        self.walkingTimeNew = [newData objectAtIndex:7];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:_stepsNew forKey:oldStepCountPrefsKey];
    [[NSUserDefaults standardUserDefaults] setFloat:_goalBarNew forKey:oldGoalBarCountPrefsKey];
    [[NSUserDefaults standardUserDefaults] setObject:_periodStepsNew forKey:oldPeriodStepsCountPrefsKey];
    [[NSUserDefaults standardUserDefaults] setObject:_distanceNew forKey:oldDistancePrefsKey];
    [[NSUserDefaults standardUserDefaults] setObject:_walkingTimeNew forKey:oldWalkingTimePrefsKey];
    [[NSUserDefaults standardUserDefaults] setObject:lastUpdate forKey:lastUpdatePrefsKey];
    
    self.dataUpdated++;
}

- (void)updateFromOldData {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.stepsNew = _stepsOld;
    self.goalBarNew = _goalBarOld;
    self.periodStepsNew = _periodStepsOld;
    self.distanceNew = _distanceOld;
    self.walkingTimeNew = _walkingTimeOld;
    
    self.dataUpdated++;
}

- (void)newDay {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _stepsOld = 0;
    _goalBarOld = 0.0f;
    _periodStepsOld = @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)];
    _distanceOld = @"0 km";
    _walkingTimeOld = @"0 m";
}

@end
