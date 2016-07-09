//
//  APIKeys.h
//  WeatherApp_v2
//
//  Created by Kenneth Pu on 7/9/16.
//  Copyright © 2016 Kenneth Pu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kBingImageSearchAPIKey;

@interface APIKeys : NSObject

+ (NSString *)valueForAPIKey:(NSString *)key;

@end
