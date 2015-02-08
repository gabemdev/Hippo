//
//  SettingsController.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import "ViewController.h"

@interface SettingsController : UIViewController<MFMailComposeViewControllerDelegate>
@property (nonatomic) NSInteger colorUpdated;

- (void)showInView:(UIView *)aView andViewController:(ViewController *)ovc;
- (void)tilePressed:(id)sender;

@end
