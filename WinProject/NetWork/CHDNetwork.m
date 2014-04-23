//
//  CHDNetwork.m
//  CHDMovie
//
//  Created by Dean on 14-3-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "CHDNetwork.h"
#import "ASIDownloadCache.h"

NSInteger response_codes  = 0;
NSInteger MAX_RETRY_LIMIT = 3;

@implementation CHDNetwork
{
    NSInteger retry;
    
    ASIBasicBlock completionBlock;
    ASIBasicBlock failedBlock;
}

+ (NSInteger) getResponseCodes
{
    return response_codes;
}

- (id) init
{
    self = [super init];
    
    if (self)
    {
        self.query       = [[NSMutableDictionary alloc] init];
        self.method      = RESTFUL_METHOD_GET;
        self.requireAuth = NO;
        self.data        = @"";
        self.timeout     = 10;
        
        self.app = [AppDelegate shareAppDelegate];
        
        response_codes  = 0;
        retry           = 0;
        MAX_RETRY_LIMIT = 3;
    }
    
    return self;
}

- (void)createRESTfulRequest
{
    [self cancelRequest];
    
    [self ensureRequestContext];
    
    self.request = [[ASIHTTPRequest alloc] initWithURL:self.url];
    
    [self.request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    
    switch (self.method)
    {
        case RESTFUL_METHOD_POST:
        case RESTFUL_METHOD_PUT:
        {
            [self.request appendPostData:[self.data dataUsingEncoding:NSUTF8StringEncoding]];
        }
            break;
            
        case RESTFUL_METHOD_GET:
            [self.request setDownloadCache:[ASIDownloadCache sharedCache]];
            [self.request setCacheStoragePolicy:ASICacheForSessionDurationCacheStoragePolicy];
            [self.request setSecondsToCache:30];
            [self.request setCachePolicy:ASIFallbackToCacheIfLoadFailsCachePolicy |
             ASIAskServerIfModifiedWhenStaleCachePolicy];
            break;
            
        default:
            break;
    }
    
    [self.request setRequestMethod:[self methodString]];
    
    
    //DEBUG
#ifdef REST_API_DEBUG
    [self.request addRequestHeader:@"DEBUG" value:REST_API_DEBUG];
#endif
    
    if (self.timeout > 0)
    {
        self.request.timeOutSeconds = self.timeout;
    }

}

// 下载数据
- (void)startAsynchronousWithProcessBlock:(void (^)(id))processBlock
                       responseBuildBlock:(id (^)(NSString *))responseBuildBlock
{
    __block CHDNetwork *ser = self;
    
    completionBlock = ^
    {
        processBlock(ser.request.responseString);
        ser = nil;
    };
    
    failedBlock = ^
    {
        response_codes += 1;
        processBlock(nil);
        ser = nil;
    };
    
    [self.request setCompletionBlock:completionBlock];
    
    [self.request setFailedBlock:failedBlock];
    
    if (self.app.isNetworkAvailable)
    {
        [self.request startAsynchronous];
    }
    else
    {
        DLog(@"STOP LOADING: REASON: (RESTFUL NETWORK EXCEPTION)");
        
        response_codes += 1;
        Alert(@"网络链接错误,请检查网络");
        
        //call back directly
        [self cancelRequest];
        processBlock(nil);
    }
}

- (void) cancelRequest
{
    if (self.request != nil)
    {
        [self.request clearDelegatesAndCancel];
        self.request = nil;
    }
}

- (void) dealloc
{
    [self cancelRequest];
}

- (void) ensureRequestContext
{
    NSMutableString *url = [[NSMutableString alloc] init];
    
    [url appendString:REST_API_URL];
//    [url appendString:[NSString stringWithFormat:@"v%d", self.version]];
//    [url appendString:@"/"];
    [url appendString:self.route];
//    [url appendString:@"."];
//    [url appendString:[self formatString]];
    
    NSUInteger i     = 0;
    NSUInteger count = [self.query count] - 1;
    
    if (self.query.count > 0)
    {
        [url appendString:@"?"];
        
        for (NSString *key in self.query.allKeys)
        {
            [url appendString:[key urlEncode]];
            [url appendString:@"="];
            [url appendString:[[self.query objectForKey:key] urlEncode]];
            
            if (i < count)
            {
                [url appendString:@"&"];
            }
            i++;
        }
    }
    
    self.url = [NSURL URLWithString:url];
    
    if ([NSString isNilOrEmpty:self.data])
    {
        self.data = @"";
    }
}

- (NSString *) sign
{
    
    return @"";
}

- (NSString *) methodString
{
    switch (self.method)
    {
        case RESTFUL_METHOD_POST:
            return @"POST";
            
        case RESTFUL_METHOD_PUT:
            return @"PUT";
            
        case RESTFUL_METHOD_DELETE:
            return @"DELETE";
            
        default:
            break;
    }
    
    return @"GET";
}

- (NSString *) formatString
{
    switch (self.format)
    {
        case RESTFUL_FORMAT_XML:
            return @"xml";
            
        default:
            break;
    }
    
    return @"json";
}

@end
