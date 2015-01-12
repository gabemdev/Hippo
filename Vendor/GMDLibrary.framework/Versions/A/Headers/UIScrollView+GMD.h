//
//  UIScrollView+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GMD)

- (void)scrollToTop;

- (void)scrollToTopAnimated:(BOOL)animated;

- (void)scrollToBottom;

- (void)scrollToBottomAnimated:(BOOL)animated;

+ (UIScrollView *)initWithFrame:(CGRect)frame
                    contentSize:(CGSize)contentSize
                  clipsToBounds:(BOOL)clipsToBounds
                  pagingEnabled:(BOOL)pagingEnabled
           showScrollIndicators:(BOOL)showScrollIndicators
                       delegate:(id<UIScrollViewDelegate>)delegate;

@end
