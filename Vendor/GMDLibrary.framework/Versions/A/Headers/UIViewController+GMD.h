//
//  UIViewController+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GMD)
//---------------------
// Handy method for popping a navController to root and scrolling a view controller
// to top. Both are common practices for iPhone apps to implement.
//---------------------

- (void)popAndScroll;

//--------------------
// Present a UIAlertView with an error message
//--------------------
- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)string;

- (UIViewController *)gmd_firstParentViewControllerOfClass:(Class)klass;

@end
