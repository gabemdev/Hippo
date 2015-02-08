//
//  AppDelegate.m
//  Goal
//
//  Created by Rockstar. on 1/9/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "IntroViewController.h"
#import "LoginViewController.h"

#import "RetreiveData.h"

NSString * const dailyGoalPrefsKey = @"goal";
NSString * const selectedUnitPrefsKey = @"unit";
NSString * const showStepsOnBadgePrefsKey = @"badge";
NSString * const backgroundColorPrefsKey = @"bgCol";
NSString * const textColorPrefsKey = @"tcCol";

NSString * const oldStepCountPrefsKey = @"oldStep";
NSString * const oldGoalBarCountPrefsKey = @"oldGoalBar";
NSString * const oldPeriodStepsCountPrefsKey = @"oldPeriodSteps";
NSString * const oldDistancePrefsKey = @"oldDistance";
NSString * const oldWalkingTimePrefsKey = @"oldWalkingTime";
NSString * const lastUpdatePrefsKey = @"lastUpdate";

NSArray *loadedData;

@interface AppDelegate ()

@end

@implementation AppDelegate
+ (void)initialize {
    // Settings
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *defaultSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @10000, dailyGoalPrefsKey,
                                     @1.0f, selectedUnitPrefsKey,
                                     @YES, showStepsOnBadgePrefsKey,
                                     @"#c0392b", backgroundColorPrefsKey,
                                     @"#0DE7A4", textColorPrefsKey,
                                     @0, oldStepCountPrefsKey,
                                     @0.0f, oldGoalBarCountPrefsKey,
                                     @[@(0.0f), @(0.0f), @(0.0f), @(0.0f), @(0.0f)], oldPeriodStepsCountPrefsKey,
                                     @"0.0 km", oldDistancePrefsKey,
                                     @"0 m", oldWalkingTimePrefsKey,
                                     [NSDate date], lastUpdatePrefsKey, nil];
    
    [userDefaults registerDefaults: defaultSettings];
}

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [NSThread sleepForTimeInterval:1.5];
    
    [self loadAppearance];
    
    [Parse setApplicationId:@"10CGQ3RqfG2y9RPZV40kTYA8qmSwg2xDGbd16qwJ"
                  clientKey:@"FgZhixYbBsm8NhPB7XLDUwtafmZ810f66rYibVrt"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults registerDefaults:@{
                                         kGoalAutomaticallyRefreshKey: @YES,
                                         kGoalDisableSleepKey: @NO,
                                         kGoalControlsHiddenKey: @NO,
                                         @"BTCMigrated": @NO
                                         }];
    
    GoalPreferences *preferences = [GoalPreferences sharedPreferences];
    [preferences registerDefaults:@{
                                    kGoalSelectedGoalKey: @"2000",
                                    kGoalNumberOfGoalKey: @0
                                    }];
    
    if (![standardDefaults boolForKey:@"BTCMigrated"]) {
        NSArray *keys = @[kGoalSelectedGoalKey, kGoalNumberOfGoalKey];
        for (NSString *key in keys) {
            [preferences setObject:[standardDefaults objectForKey:key] forKey:key];
        }
        [preferences synchronize];
        
        [standardDefaults setBool:YES forKey:@"BTCMigrated"];
        [standardDefaults synchronize];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor GMDColorWithHex:@"0DE7A4"];
    
    
    [self _checkUser];
    UIViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [navController.navigationBar setTranslucent:NO];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
    
    if ([IntroViewController shouldRunWelcomeFlow]) {
        IntroViewController *introViewController;
        introViewController = [[IntroViewController alloc] init];
        
        introViewController.nextViewController = self.window.rootViewController;
        [self.window setRootViewController:introViewController];
    }
    
    self.window.clipsToBounds = YES;
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    GMDDispatchOnMain(^{
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        NSString *versionString = [NSString stringWithFormat:@"%@ (%@)",
                                   info[@"CFBundleShortVersionString"],
                                   info[@"CFBundleVersion"]];
        [standardDefaults setObject:versionString forKey:@"GoalVersion"];
        [standardDefaults synchronize];
    });
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self _checkUser];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loadAppearance {
    UIApplication *application = [UIApplication sharedApplication];
    application.statusBarStyle = UIStatusBarStyleLightContent;
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barStyle = UIBarStyleBlack;
    navigationBar.barTintColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    navigationBar.tintColor = [UIColor colorWithWhite:1.0 alpha:0.5f];
    navigationBar.titleTextAttributes = @{
                                          NSForegroundColorAttributeName: [UIColor whiteColor],
                                          NSFontAttributeName: [UIFont fontWithName:@"Avenir-Medium" size:20.0]
                                          };
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}

#pragma mark - Settings
-(BOOL)pushNotificationOnOrOff{
    
    BOOL pushEnabled=NO;
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        pushEnabled=YES;
    }
    else {
        pushEnabled=NO;
    }
    
    return pushEnabled;
}

-(void)showError:(NSString*)errorMessage{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [alertView show];
    });
}

- (void)_checkUser {
    PFUser *currentUser = [PFUser currentUser];
    if (!currentUser) {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:nav];
    }
    return;
    
    
}


@end
