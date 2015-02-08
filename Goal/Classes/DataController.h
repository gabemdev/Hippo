//
//  DataController.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject
@property (nonatomic, strong) NSString *date;

@property (nonatomic) NSInteger stepsNew;
@property (nonatomic) float goalBarNew;
@property (nonatomic, strong) NSArray *periodStepsNew;
@property (nonatomic, strong) NSString *distanceNew;
@property (nonatomic, strong) NSString *walkingTimeNew;

@property (nonatomic) NSInteger stepsOld;
@property (nonatomic) float goalBarOld;
@property (nonatomic, strong) NSArray *periodStepsOld;
@property (nonatomic, strong) NSString *distanceOld;
@property (nonatomic, strong) NSString *walkingTimeOld;

@property (nonatomic) NSInteger dataUpdated;

+ (id)sharedManager;
- (void)decideIfIsUpdateNecessary;

@end
