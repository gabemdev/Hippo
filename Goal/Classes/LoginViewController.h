//
//  LoginViewController.h
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderView.h"

@interface LoginViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic, readonly) HeaderView *headerView;
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;

@end
