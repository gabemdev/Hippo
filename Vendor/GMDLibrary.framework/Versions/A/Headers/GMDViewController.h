//
//  GMDViewController.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDViewController : UIViewController
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

@end
