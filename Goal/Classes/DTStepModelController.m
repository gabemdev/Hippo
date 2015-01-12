//
//  DTStepModelController.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DTStepModelController.h"

@interface DTStepModelController ()

@property (assign) NSInteger stepsToday;
@end

@implementation DTStepModelController {
    CMStepCounter *_stepCounter;
    NSInteger _stepsToday;
    NSInteger _stephsAtBeginOfLiveCounting;
    BOOL _isLiveCounting;
    NSOperationQueue *_stepsQueue;
}

- (instancetype)init {
    if ((self = [super init])) {
        _stepCounter = [[CMStepCounter alloc] init];
        self.stepsToday = -1;
        
        NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
        [noteCenter addObserver:self selector:@selector(timeChangedSignificantly:) name:UIApplicationSignificantTimeChangeNotification object:nil];
        [noteCenter addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [noteCenter addObserver:self selector:@selector(didEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        _stepsQueue = [[NSOperationQueue alloc] init];
        _stepsQueue.maxConcurrentOperationCount = 1;
        
        [self _updateStepsTodayFromHistoryLive:YES];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_updateStepsTodayFromHistoryLive:(BOOL)startLiveCounting
{
    if (![CMStepCounter isStepCountingAvailable]) {
        NSLog(@"Step counting not available on this device");
        
        self.stepsToday = -1;
        return;
    }
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:now];
    
    NSDate *beginOfDay = [calendar dateFromComponents:components];
    
    [_stepCounter queryStepCountStartingFrom:beginOfDay
                                          to:now
                                     toQueue:_stepsQueue withHandler:^(NSInteger numberOfSteps, NSError *error) {
                                         if (error) {
                                             NSLog(@"%@", [error localizedDescription]);
                                             self.stepsToday = -1;
                                         } else {
                                             self.stepsToday = numberOfSteps;
                                             if (startLiveCounting) {
                                                 [self _startLiveCounting];
                                             }
                                         }
                                     }];
}

- (void)_startLiveCounting {
    if (_isLiveCounting) {
        return;
    }
    
    _isLiveCounting = YES;
    _stephsAtBeginOfLiveCounting = self.stepsToday;
    [_stepCounter startStepCountingUpdatesToQueue:_stepsQueue
                                         updateOn:1
                                      withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
                                          self.stepsToday = _stephsAtBeginOfLiveCounting + numberOfSteps;
                                      }];
    NSLog(@"Started Live step counting");
}

- (void)_stopLiveCounting
{
    if (!_isLiveCounting) {
        return;
    }
    
    [_stepCounter stopStepCountingUpdates];
    _isLiveCounting = NO;
    
    NSLog(@"Stopped live step counting");
}

- (void)timeChangedSignificantly:(NSNotification *)notification {
    [self _stopLiveCounting];
    [self _updateStepsTodayFromHistoryLive:YES];
}

- (void)willEnterForeground:(NSNotification *)notification {
    [self _updateStepsTodayFromHistoryLive:YES];
}

- (void)didEnterBackground:(NSNotification *)notification {
    [self _stopLiveCounting];
}
@end
