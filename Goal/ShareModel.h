//
//  ShareModel.h
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ShareModel : NSObject
- (UIActivityViewController *)getShareView:(UIView *)view;

@end
