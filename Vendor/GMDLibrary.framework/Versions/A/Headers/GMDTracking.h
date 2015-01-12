//
//  GMDTracking.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//


#ifndef ANALYTICS_ENABLED
#define ANALYTICS_ENABLED (!DEBUG && !TARGET_IPHONE_SIMULATOR)
#endif

#if ANALYTICS_ENABLED
#import "LocalyticsSession.h"
#endif


@interface GMDTracking : NSObject

+ (GMDTracking *)sharedInstance;

void LLStartSession(NSString *key);
void LLTagEvent(NSString *name);
void LLTagEventWithAttributes(NSString *name, NSNumber *value, NSString *sender);
void LLTagScreen(NSString *name);

- (void)trackEvent:(NSString *)event withValue:(NSNumber *)value fromSender:(NSString *)sender;


//Initial Setup
- (void) LLWillResignActive;
- (void) LLDidEnterBackground;
- (void) LLWillEnterForeground;
- (void) LLDidBecomeActive;
- (void) LLWillTerminate;

@end
