//
//  Goalbar.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Goalbar : UIView
@property (nonatomic, strong) CALayer *outline;
@property (nonatomic, strong) CALayer *fill;

- (void)updateFillFrom:(float)from to:(float)to;


@end
