//
//  UIControl+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (GMD)

- (void)gmd_removeAllTargets;

- (void)gmd_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
