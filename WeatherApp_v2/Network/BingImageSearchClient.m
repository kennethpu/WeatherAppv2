//
//  BingImageSearchClient.m
//  WeatherApp_v2
//
//  Created by Kenneth Pu on 6/12/16.
//  Copyright © 2016 Kenneth Pu. All rights reserved.
//

#import "BingImageSearchClient.h"
#import "APIKeys.h"

NSString *const bingRequestHeaderKey = @"Ocp-Apim-Subscription-Key";

@interface BingImageSearchClient ()

@property (nonatomic, readonly) NSURLSession *session;

@end

@implementation BingImageSearchClient

+ (BingImageSearchClient *)sharedInstance {
    static BingImageSearchClient *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BingImageSearchClient alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        // Create Session Configuration
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSString *bingAPIKey = [APIKeys valueForAPIKey:kBingImageSearchAPIKey];
        [sessionConfiguration setHTTPAdditionalHeaders:@{ bingRequestHeaderKey : bingAPIKey }];
        
        // Create Session
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    return self;
}

- (void)fetchImagesForQuery:(NSString *)q
                   callback:(void (^)(NSDictionary *))callback {
    [self fetchImagesForQuery:q count:1 offset:0 market:@"en-us" safeSearch:@"Moderate" callback:callback];
}

- (void)fetchImagesForQuery:(NSString *)q
                      count:(NSInteger)count
                     offset:(NSInteger)offset
                     market:(NSString *)mkt
                 safeSearch:(NSString *)safeSearch
                   callback:(void (^)(NSDictionary *))callback {
    // Set up base url
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.scheme = @"https";
    urlComponents.host = @"bingapis.azure-api.net";
    urlComponents.path = @"/api/v5/images/search";
    
    // Set up query parameters
    NSURLQueryItem *subjectQuery = [[NSURLQueryItem alloc] initWithName:@"q" value:q];
    NSURLQueryItem *countQuery = [[NSURLQueryItem alloc] initWithName:@"count" value:[@(count) stringValue]];
    NSURLQueryItem *offsetQuery = [[NSURLQueryItem alloc] initWithName:@"offset" value:[@(offset) stringValue]];
    NSURLQueryItem *marketQuery = [[NSURLQueryItem alloc] initWithName:@"mkt" value:mkt];
    NSURLQueryItem *safeSearchQuery = [[NSURLQueryItem alloc] initWithName:@"safeSearch" value:safeSearch];
//    NSURLQueryItem *aspectQuery = [[NSURLQueryItem alloc] initWithName:@"aspect" value:@"Tall"];
    NSURLQueryItem *typeQuery = [[NSURLQueryItem alloc] initWithName:@"imageType" value:@"Photo"];
    urlComponents.queryItems = @[subjectQuery, countQuery, offsetQuery, marketQuery, safeSearchQuery, typeQuery];
    
    // Make request
    NSURL *queryURL = urlComponents.URL;
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:queryURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", [jsonDict[@"value"] valueForKey:@"contentUrl"]);
        if (callback) {
            callback(jsonDict);
        }
    }];
    [dataTask resume];
}

@end
