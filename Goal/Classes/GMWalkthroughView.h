//
//  GMWalkthroughView.h
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMWalkthroughPage.h"

enum GMIntroViewTags {
    kTitleLabelTag = 1,
    kDescLabelTag,
    kTitleImageViewTag
};

@class GMWalkthroughView;

@protocol GMWalkthroughDelegate
@optional
- (void)introDidFinish:(GMWalkthroughView *)introView;
- (void)intro:(GMWalkthroughView *)introView pageAppeared:(GMWalkthroughPage *)page withIndex:(NSInteger)pageIndex;
- (void)intro:(GMWalkthroughView *)introView pageStartScrolling:(GMWalkthroughPage *)page withIndex:(NSInteger)pageIndex;
- (void)intro:(GMWalkthroughView *)introView pageEndScrolling:(GMWalkthroughPage *)page withIndex:(NSInteger)pageIndex;
@end

@interface GMWalkthroughView : UIView <UIScrollViewDelegate>

@property (nonatomic, weak)id<GMWalkthroughDelegate> delegate;

// titleView Y position - from top of the screen
// pageControl Y position - from bottom of the screen
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool tapToNext;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, assign) bool easeOutCrossDisolves;
@property (nonatomic, assign) bool showSkipButtonOnlyOnLastPage;
@property (nonatomic, assign) bool useMotionEffects;
@property (nonatomic, assign) CGFloat motionEffectsRelativeValue;
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, assign) UIViewContentMode bgViewContentMode;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, assign) NSInteger visiblePageIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;

- (void)setCurrentPageIndex:(NSInteger)currentPageIndex;
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex animated:(BOOL)animated;


@end
