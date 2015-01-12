//
//  GMTextField.h
//  GMDLibrary
//
//  Created by Rockstar. on 8/25/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

@interface GMTextField : UITextField

///------------------------------------
/// @name Accessing the Text Attributes
///------------------------------------

/**
 The color of the placeholder text
 */
@property (nonatomic) UIColor *placeHolderTextColor;

///------------------------------------
/// @name Drawing and Positioning
///------------------------------------

/**
 The inset our outset margins for the edges of the text content drawing rectangle.
 */
@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

/**
 The inset or outset margins for the edges of the clear buttong drawing rectangle.
 */
@property (nonatomic, assign) UIEdgeInsets clearButtonEdgeInsets;

@property (nonatomic) UIEdgeInsets rightViewInsets;

@property (nonatomic) UIEdgeInsets leftViewInsets;

@end
