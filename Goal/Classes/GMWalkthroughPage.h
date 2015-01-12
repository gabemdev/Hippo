//
//  GMWalkthroughPage.h
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)();

@interface GMWalkthroughPage : NSObject

@property (nonatomic) UIImage *bgImage;
@property (nonatomic, assign) BOOL showTitleView;

@property (nonatomic, strong) UIView * titleIconView;

@property (nonatomic, assign) CGFloat titleIconPositionY;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) UIFont *descFont;
@property (nonatomic, strong) UIColor *descColor;
@property (nonatomic, assign) CGFloat descWidth;
@property (nonatomic, assign) CGFloat descPositionY;

@property (nonatomic, strong) NSArray *subviews;

@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic,copy) VoidBlock onPageDidLoad;
@property (nonatomic,copy) VoidBlock onPageDidAppear;
@property (nonatomic,copy) VoidBlock onPageDidDisappear;


// if customView is set - all other default properties are ignored
@property (nonatomic, strong) UIView *customView;

@property(nonatomic, strong, readonly) UIView *pageView;

+ (instancetype)page;
+ (instancetype)pageWithCustomView:(UIView *)customV;
+ (instancetype)pageWithCustomViewFromNibNamed:(NSString *)nibName;

@end
