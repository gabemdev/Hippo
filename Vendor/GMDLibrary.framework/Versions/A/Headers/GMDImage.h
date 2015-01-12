//
//  GMDImage.h
//  GMDLibrary
//
//  Created by Rockstar. on 1/1/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMDImage : UIImage

/**
 Returns the image object associated with the specified filename.
 
 This method looks in the system caches for an image object with the specified name and returns that object if it
 exists. If a matching image object is not already in the cache, this method loads the image data from the specified
 file, caches it, and then returns the resulting object.
 
 @param imageName The name of the file. If this is the first time the image is being loaded, the method looks for an image
 with the specified name in the specified bundle.
 
 @param bundleName The name of the bundle to search for the image. Specify `nil` to use the main bundle.
 
 @return The image object for the specified file, or `nil` if the method could not find the specified image.
 */
+ (UIImage *)imageNamed:(NSString *)imageName bundleName:(NSString *)bundleName;

- (UIImage *)imageCroppedToRect:(CGRect)rect;
- (UIImage *)squareImage;

@property (nonatomic, assign, readonly) NSInteger rightCapWidth;
@property (nonatomic, assign, readonly) NSInteger bottomCapHeight;

@end
