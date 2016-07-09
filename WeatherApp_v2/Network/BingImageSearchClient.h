//
//  BingImageSearchClient.h
//  WeatherApp_v2
//
//  Created by Kenneth Pu on 6/12/16.
//  Copyright © 2016 Kenneth Pu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BingImageSearchClient : NSObject<NSURLSessionDelegate>

+ (BingImageSearchClient *)sharedInstance;

- (void)fetchImagesForQuery:(NSString *)q
                   callback:(void (^)(NSDictionary *))callback;

- (void)fetchImagesForQuery:(NSString *)q
                      count:(NSInteger)count
                     offset:(NSInteger)offset
                     market:(NSString *)mkt
                 safeSearch:(NSString *)safeSearch
                   callback:(void (^)(NSDictionary *))callback;

@end
