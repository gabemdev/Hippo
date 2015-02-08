//
//  SignUpViewController.h
//  Goal
//
//  Created by Rockstar. on 1/11/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainProfile.h"

@interface SignUpViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) UIImage *image;

@property (nonatomic, readonly) MainProfile *profile;
@property (nonatomic) UITextField *name;
@property (nonatomic) UITextField *lastName;
@property (nonatomic) UITextField *email;
@property (nonatomic) UITextField *password;

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;
- (void)uploadImage:(NSData *)imageData;

@end
