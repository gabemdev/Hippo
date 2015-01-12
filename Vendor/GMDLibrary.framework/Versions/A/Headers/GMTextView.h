//
//  GMTextView.h
//  GMDLibrary
//
//  Created by Rockstar. on 8/25/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

@interface GMTextView : UITextView

@property (nonatomic) NSString *holder;
@property (nonatomic) UIColor *holderTextColor;
- (CGRect)holderRectForBounds:(CGRect)bounds;
@end
