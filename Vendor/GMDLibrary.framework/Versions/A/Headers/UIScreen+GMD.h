//
//  UIScreen+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (GMD)
// Returns the bounds of the screen for the current device orientation.
// @return A rect indicating the bounds of the screen.
// @see boundsForOrientation:

- (CGRect)currentBounds;
- (CGRect)boundsForOrientation:(UIInterfaceOrientation)orientation;
- (BOOL)isRetinaDisplay;
- (BOOL)isTall;

@end
