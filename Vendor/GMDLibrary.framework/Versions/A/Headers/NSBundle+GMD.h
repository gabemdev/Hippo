//
//  NSBundle+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/29/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#define GMDLibraryLocalizedString(key) [[NSBundle gmdLibraryBundle] localizedStringForKey:(key) value: @"" table:@"GMDLibrary"]

@interface NSBundle (GMD)

+ (NSBundle *)gmdLibraryBundle;

@end
