//
//  ShareModel.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "ShareModel.h"

@implementation ShareModel

- (UIActivityViewController *)getShareView:(UIView *)view {
    NSString *text = @"Check out my activity level today! \nShared from StepTracker: ";
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/dk/app/steptracker/id906358966?mt=8"];
    UIImage *screenshot = [self captureScreenshot:view];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:@[screenshot, text, url] applicationActivities:nil];
    avc.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypePrint];
    
    return avc;
}

- (UIImage *)captureScreenshot:(UIView *)screenView {
    UIGraphicsBeginImageContextWithOptions(screenView.bounds.size, NO, 0);
    [screenView drawViewHierarchyInRect:screenView.bounds afterScreenUpdates:YES];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

@end
