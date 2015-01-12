//
//  GMDRequestService.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/27/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMDDispatch.h"

@interface GMDRequestService : NSObject

+ (GMDRequestService *)sharedInstance;

- (void)asyncRequest:(NSURL *)url complete:(GMDRequestBlock)block;
- (void)asyncJSONRequest:(NSURL *)url completion:(GMDObjectBlock)block;
- (void)asyncImageRequest:(NSURL *)url completion:(GMDImageBlock)block;


@end
