//
//  UIApplication+GMD.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/2/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (GMD)

- (NSURL *)gmd_documentsDirectoryURL;

- (NSURL *)gmd_cachesDirectoryURL;

- (NSURL *)gmd_downloadsDirectoryURL;

- (NSURL *)gmd_libraryDirectoryURL;

- (NSURL *)gmd_applicationSupportDirectoryURL;


- (void)gmd_setNetworkActivity:(BOOL)inProgress;

- (BOOL)gmd_isPirated;

@end
