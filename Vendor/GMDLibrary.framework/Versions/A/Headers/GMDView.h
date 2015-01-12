//
//  GMDView.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDView : UIView

//--------------------
// Taking Screenshots
//--------------------
- (UIImage *)imageRepresentation;

//--------------------
// Fading In and Out
//--------------------
- (void)hide;
- (void)show;
- (void)fadeOut;
- (void)fadeOutAneRemoveFromSuperView;
- (void)fadeIn;

//-------------------
// Managing the view Hierarchy
//-------------------
- (NSArray *)superviews;
- (instancetype)firstSuperviewOfClass:(Class)superviewClass;

@end
