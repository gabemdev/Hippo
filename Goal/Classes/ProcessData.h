//
//  ProcessData.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessData : NSObject

- (NSString *)todaysDate;
- (NSArray *)processDataWithNewData:(NSArray *)newData andOldData:(NSArray *)oldData;
- (NSArray *)noStepsYet;
- (void)updateIconBadgeNumber:(NSInteger)stepCount;

@end
