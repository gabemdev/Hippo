//
//  SignUpViewController.h
//  Goal
//
//  Created by Rockstar. on 1/11/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic) UIImage *image;

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height;

@end
