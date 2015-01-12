//
//  GMDAPIClient.h
//  GMDLibrary
//
//  Created by Rockstar. on 12/28/14.
//  Copyright (c) 2014 Fantastik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMDAPIClient : NSObject

+ (GMDAPIClient *)sharedInstance;

- (void)setAccessToken:(NSString *)accessToken secret:(NSString *)secret;

/*---------------
 Usage Example:
 @property (strong, nonatomic) NSDictionary *authAttributes;
 - (void)setAuthAttributes:(NSDictionary *)authAttributes;
 
 @synthesize authAttributes = _authAttributes;
 
 if (authAttributes) {
 NSDictionary *credentials = [authAttributes objectForKey:@"credentials"];
 self.accessToken = [credentials objectForKey:@"token"];
 self.secretToken = [credentials objectForKey:@"secret"];
 
 GMDAPIClient *apiClient = [GMDAPIClient sharedInstance];
 [apiClient setAccessToken:self.accessToken
 secret: self.secretToken];
 
 ...
 
 }
 
 -------------------*/

@end
