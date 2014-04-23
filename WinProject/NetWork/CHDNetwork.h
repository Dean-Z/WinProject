//
//  CHDNetwork.h
//  CHDMovie
//
//  Created by Dean on 14-3-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "AppDelegate.h"

typedef enum {
    RESTFUL_METHOD_GET = 0,
    RESTFUL_METHOD_POST = 1,
	RESTFUL_METHOD_PUT = 2,
	RESTFUL_METHOD_DELETE = 3
} RESTfulMethod;

typedef enum {
    RESTFUL_FORMAT_JSON,
    RESTFUL_FORMAT_XML
} RESTfulFormat;

@interface CHDNetwork : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic) RESTfulMethod method;
@property (nonatomic, strong) AppDelegate *app;
@property (nonatomic, strong) NSString *route;
@property (nonatomic, strong) NSMutableDictionary *query;
@property (nonatomic, strong) NSDictionary *postData;
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *cacheTimestamp;
@property (nonatomic) BOOL requireAuth;
@property (nonatomic) int timeout;
@property (nonatomic) RESTfulFormat format;
@property (nonatomic, strong) NSDate *expiration;
@property (nonatomic, strong) ASIHTTPRequest *request;

+ (NSInteger)getResponseCodes;

- (void)ensureRequestContext;
- (void)cancelRequest;
- (void)createRESTfulRequest;
- (void)startAsynchronousWithProcessBlock:(void (^)(id))processBlock
                       responseBuildBlock:(id (^)(NSString *))responseBuildBlock;

- (NSString *)sign;

@end
