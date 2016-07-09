//
//  APIKeys.m
//  WeatherApp_v2
//
//  Created by Kenneth Pu on 7/9/16.
//  Copyright © 2016 Kenneth Pu. All rights reserved.
//

#import "APIKeys.h"

NSString *const kBingImageSearchAPIKey = @"BING_IMAGE_SEARCH_API_KEY";

@implementation APIKeys

+ (NSString *)valueForAPIKey:(NSString *)key {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"];
    NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    NSString *apiKey = [plist valueForKey:key];
    return apiKey;
}

@end
