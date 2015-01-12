//
//  IntroViewController.h
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMWalkthroughView.h"

@interface IntroViewController : UIViewController <GMWalkthroughDelegate>
@property UIViewController *nextViewController;

+ (BOOL) shouldRunWelcomeFlow;
+ (void) setShouldRunWelcomeFlow:(BOOL)should;
@end
