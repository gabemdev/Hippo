//
//  GMDLabel.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/29/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

//------------------
// The veritcal alignment of text within a label
//------------------

typedef enum {
    // Aligns the text vertically at the top in the label (Default)
    GMDLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
    
    //Aligns the text vertically in the center of the label.
    GMDLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
    
    // Aligns the text vertically at the bottom of the label.
    GMDLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} GMDLabelVerticalTextAlignment;

// UILabel subclass that adds the ability to align your text to the top or bottom.
@interface GMDLabel : UILabel

// The vertical text alignment of the receiver.
// The default is `GMDLabelVerticalTextAlignmentMiddle` to match `UILabel`.
@property (nonatomic, assign) GMDLabelVerticalTextAlignment verticalTextAlignment;

//The edge insets of the text.
// The default is `UIEdgeInsetsZero` so it behaves like `UiLabel` by default.
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@end
