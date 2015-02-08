//
//  DataViewController.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "DataViewController.h"
#import "DataController.h"

#import "ShareModel.h"
#import "SettingsController.h"

@interface DataViewController ()

@property (nonatomic, strong) DataController *dataController;

@property (nonatomic, strong) SettingsController *settingsController;
@property (nonatomic, strong) ShareModel *shareModel;

@end

@implementation DataViewController

{
    NSUserDefaults *settings;
    BOOL circleLabelsDisplayName;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if ([CMPedometer isStepCountingAvailable])  [self initialize];
    else                                        [self showNotAuthorizedAlert:NO];
}

#pragma INITIALIZATION
- (void)initialize {
    
    if (debugEnabled) NSLog(@"DEBUG MODE ENABLED");
    
    // Data models
    _dataController = [DataController sharedManager];
    
    // Create KVO
    [_dataController addObserver:self
                      forKeyPath:@"dataUpdated"
                         options:NSKeyValueObservingOptionNew
                         context:NULL];
    
    circleLabelsDisplayName = YES;
    
}

#pragma KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

}

#pragma UPDATE METHOD
- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // If motion activity authorization is turned of show alert.
        if (!coreMotionAuthorized) {
            //[self showNotAuthorizedAlert:YES];
            [self showError:retrivalError];
        }
    });
}

- (void)switchButtonLabels:(id)sender {
    if (circleLabelsDisplayName) {

        circleLabelsDisplayName = NO;
    } else {

        circleLabelsDisplayName = YES;
    }
}

- (void)settingsButton:(id)sender {
    _settingsController = [[SettingsController alloc] initWithNibName:@"SettingsView" bundle:nil];
    
    [self.settingsController showInView:self.view andViewController:self];
}

- (void)shareButton:(id)sender {
    _shareModel = [[ShareModel alloc] init];
    [self presentViewController:[_shareModel getShareView:self.view] animated:YES completion:nil];
}

- (void)showNotAuthorizedAlert:(BOOL)M7Compatible {
    NSString *alertTitle = @"";
    NSString *alertMessage = @"";
    
    if (M7Compatible) {
        alertTitle = @"Whoops!";
        alertMessage =[NSString stringWithFormat:@"%@ needs permission to collect your steps. You can reactivate StepTracker's permission in the privacy menu in Settings.", appName];
    } else {
        alertTitle = @"No iPhone 5s, 6 or 6 Plus?";
        alertMessage = [NSString stringWithFormat:@"%@ uses the build-in M7 processor to track your steps. Unfortunately the app won't work on your device. \nI hope to see you again in the future.", appName];
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)showError:(NSString *)errorMessage {
    NSString *alertTitle = @"Error";
    NSString *alertMessage = errorMessage;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)dealloc {
    [_dataController removeObserver:self forKeyPath:@"dataUpdated"];
}


@end
