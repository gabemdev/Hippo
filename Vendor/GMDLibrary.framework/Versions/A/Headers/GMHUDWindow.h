//
//  GMHUDWindow.h
//  GMDLibrary
//
//  Created by Rockstar. on 8/25/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMHUDWindow : UIWindow

@property (nonatomic, assign) BOOL hidesVignette;

+ (GMHUDWindow *)defaultWindow;

@end
