//
//  GMDTwitterProfile.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDTwitterProfile : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSNumber* followerCount;
@property (nonatomic, strong) NSNumber* followingCount;
@property (nonatomic, strong) NSNumber* twitterId;
@property (nonatomic, strong) NSString* screenName;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* profileImageUrl;
@property (nonatomic, strong) NSString* profileBannerUrl;
@property (nonatomic, strong) NSString *descriptionLabel;


-(GMDTwitterProfile *)initWithJSON:(NSDictionary*)jsonObject;

@end
