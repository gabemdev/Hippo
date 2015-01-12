//
//  GMDUser.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const UserDidLoginNotification;
extern NSString *const UserDidLogoutNotification;

@interface GMDUser : NSObject

+ (GMDUser *)sharedInstance;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *secretToken;

@property (strong, nonatomic) NSString *facebookToken;
@property (strong, nonatomic) NSString *linkedIntoken;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *bannerImageUrl;
@property (strong, nonatomic) NSString *followerCount;
@property (strong, nonatomic) NSString *followingCount;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *email;

- (void)loginWithDictionary:(NSDictionary *)dictionary;
- (BOOL)isLoggedIn;
- (void)logout;


/*
 Usage Example: 
 .h
 @property (nonatomic, weak) GMDUser *user;
 
 .m
 GMDUser *user = [GMDUser sharedInstance];
 NSString *profile = user.profileImageUrl;
 self.profile.status.text = user.status;
 
*/

@end
