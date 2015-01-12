//
//  GMButton.h
//  GMDLibrary
//
//  Created by Rockstar. on 8/25/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

typedef enum {
    GMButtonImagePositionLeft,
    GMButtonImagePositionRight
} GMButtonImagePosition;

@interface GMButton : UIButton

@property (nonatomic, assign) GMButtonImagePosition imagePosition;


@end
