//
//  GMWalkthroughPage.m
//  Goal
//
//  Created by Rockstar. on 1/10/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "GMWalkthroughPage.h"

#define DEFAULT_DESCRIPTION_LABEL_SIDE_PADDING 25
#define DEFAULT_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]
#define DEFAULT_LABEL_COLOR [UIColor whiteColor]
#define DEFAULT_DESCRIPTION_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0]
#define DEFAULT_TITLE_IMAGE_Y_POSITION 50.0f
#define DEFAULT_TITLE_LABEL_Y_POSITION 160.0f
#define DEFAULT_DESCRIPTION_LABEL_Y_POSITION 140.0f

@interface GMWalkthroughPage ()
@property(nonatomic, strong, readwrite) UIView *pageView;
@end

@implementation GMWalkthroughPage

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        _titleIconPositionY = DEFAULT_TITLE_IMAGE_Y_POSITION;
        _titlePositionY  = DEFAULT_TITLE_LABEL_Y_POSITION;
        _descPositionY   = DEFAULT_DESCRIPTION_LABEL_Y_POSITION;
        _title = @"";
        _titleFont = DEFAULT_TITLE_FONT;
        _titleColor = DEFAULT_LABEL_COLOR;
        _desc = @"";
        _descFont = DEFAULT_DESCRIPTION_FONT;
        _descColor = DEFAULT_LABEL_COLOR;
        _showTitleView = YES;
        _alpha = 1.0f;
    }
    return self;
}

+ (instancetype)page {
    return [[self alloc] init];
}

+ (instancetype)pageWithCustomView:(UIView *)customV {
    GMWalkthroughPage *newPage = [[self alloc] init];
    newPage.customView = customV;
    return newPage;
}

+ (instancetype)pageWithCustomViewFromNibNamed:(NSString *)nibName {
    return [self pageWithCustomViewFromNibNamed:nibName bundle:[NSBundle mainBundle]];
}

+ (instancetype)pageWithCustomViewFromNibNamed:(NSString *)nibName bundle:(NSBundle*)aBundle {
    GMWalkthroughPage *newPage = [[self alloc] init];
    newPage.customView = [[aBundle loadNibNamed:nibName owner:newPage options:nil] firstObject];
    return newPage;
}

@end
