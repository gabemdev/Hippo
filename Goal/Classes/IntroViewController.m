//
//  IntroViewController.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "IntroViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PageControl.h"
#import "LoginViewController.h"
#import "ViewController.h"

static NSString * const sampleDescription1 = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
static NSString * const sampleDescription2 = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
static NSString * const sampleDescription3 = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
static NSString * const sampleDescription4 = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";

@interface IntroViewController () {

    LoginViewController *rootView;
}

@end

NSString *nsuserdefaultsHasRunFlowKeyName = @"com.gabemdev.hasRunWelcomeFlow";

@implementation IntroViewController
@synthesize nextViewController = _nextViewController;

+ (BOOL) shouldRunWelcomeFlow {
    //You should run if not yet run
    return ![[NSUserDefaults standardUserDefaults] boolForKey:nsuserdefaultsHasRunFlowKeyName];
}

+ (void) setShouldRunWelcomeFlow:(BOOL)should {
    //ShouldRun is opposite of hasRun
    [[NSUserDefaults standardUserDefaults] setBool:!should forKey:nsuserdefaultsHasRunFlowKeyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        NSLog(@"IntroViewController showing");
    
    GMWalkthroughPage *page1 = [GMWalkthroughPage page];
    page1.title = @"Welcome to Goal!";
    page1.desc = sampleDescription1;
    
    GMWalkthroughPage *page2 = [GMWalkthroughPage page];
    page2.title = @"Set your goals and reach them!";
    page2.desc = sampleDescription2;
    
    GMWalkthroughPage *page3 = [GMWalkthroughPage page];
    page3.title = @"Plan your day and check the weather";
    page3.desc = sampleDescription3;
    
    GMWalkthroughPage *page4 = [GMWalkthroughPage page];
    page4.title = @"Share and invite your friends";
    page4.desc = sampleDescription4;
    
    GMWalkthroughView *intro = [[GMWalkthroughView alloc] initWithFrame:self.view.bounds andPages:@[page1, page2, page3, page4]];
    [intro setDelegate:self];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    intro.titleView = titleView;
    intro.titleViewY = 90;
    intro.backgroundColor = [UIColor GMDColorWithHex:@"#0DE7A4"];
    
    [intro showInView:self.view animateDuration:0.3];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
- (void)introDidFinish:(GMWalkthroughView *)introView {
//    LoginViewController *view = [[LoginViewController alloc] init];
//    UINavigationController *detail = [[UINavigationController alloc] initWithRootViewController:view];
//    detail.modalPresentationStyle = UIModalPresentationPopover;
//    
//    UIPopoverPresentationController *popover = detail.popoverPresentationController;
//    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    
//    [self presentViewController:detail animated:YES completion:^{
//    }];
    
    [IntroViewController setShouldRunWelcomeFlow:NO];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:self.nextViewController];
}

@end
