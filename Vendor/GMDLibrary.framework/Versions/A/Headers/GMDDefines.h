//
//  GMDDefines.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#ifndef GMDDEFINES
#define GMDDEFINES 1
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define kGMDLocalyticsKey @"key"

#define kGMDTwitterConsumerKey @"consumerKey"
#define kGMDTwitterSecretKey @"secretKey"

#define kGMDParseApplicationID @"ApplicationID"
#define kGMDParseClientKey @"ClientKey"

#define kGMDAPIClientID @"YOUR_API_KEY"
#define kGMDAPIClientSecret @"YOUR_SECRET_KEY"

#define kGMDSuiteName @"group.com.gabemdev.app"



@import Foundation;

extern NSString *const kGMDAutomaticallyRefresh;
extern NSString *const kGMDRoundTableDidChangeNotificationName;
extern NSString *const kGMDDisableSleepKey;

#endif

#pragma mark - Parse Constants
extern NSString *const GMD_PARSE_APPLICATION_ID;
extern NSString *const GMD_PARSE_CLIENT_KEY;

#pragma mark - Twitter Constants
extern NSString *const GMD_TWITTER_CONSUMER_KEY;
extern NSString *const GMD_TWITTER_CONSUMER_SECRET;

#pragma mark - Fonts

extern NSString *const kGMDRegularFontName;
extern NSString *const kGMDBoldFontName;
extern NSString *const kGMDBoldItalicFontName;
extern NSString *const kGMDItalicFontName;
extern NSString *const kGMDExtraBoldFontName;
extern NSString *const kGMDExtraBoldItalicFontName;
extern NSString *const kGMDLightFontName;
extern NSString *const kGMDLightItalicFontName;
extern NSString *const kGMDSemiboldFontName;
extern NSString *const kGMDSemiboldItalicFontName;

#pragma mark - API
extern NSString *const kHSIAPIClientID;
extern NSString *const kHSIAPIClientSecret;


