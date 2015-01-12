//
//  GMDDispatch.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/27/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDDispatch : NSObject

typedef void (^GMDBooleanBlock)(BOOL succeedded, NSError *error);
typedef void (^GMDIntegerBlock)(int number, NSError *error);
typedef void (^GMDArrayBlock)(NSArray *objects, NSError *error);
typedef void (^GMDObjectBlock)(id object, NSError *error);
typedef void (^GMDImageBlock)(UIImage *image, NSError *error);
typedef void (^GMDRequestBlock)(NSData *data, NSURLResponse *response, NSError *error);
typedef void (^GMDBlock)(void);

//---------------------
// Queues up the given block to be executed on main thread
//---------------------

void GMDDispatchOnMain(void (^block)());
/*----------------------------
 Example:
 GMDDispatchOnMain(^{
 [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
 });
 -----------------------------*/

//---------------------
// Queues up the given block to be executed on the CURRENT thread after at least n seconds
//---------------------

void GMDDispatchAfter(float seconds, void(^block)());
/*----------------------------
 Example:
 GMDDispatchAfter(0.1, ^{
 [self _animatePictureAtIndex: index+1 completion:block];
 });
 ------------------------------*/

//---------------------
// Queues up a calculation to run on background
//---------------------

void GMDDispatchBackground(void (^block)());

void GMDDispatchOnce(void (^block)());

void GMDDispatchAsync(void (^block)());

void GMDDispatchAfterGlobal(float seconds, void(^block)());

@end
