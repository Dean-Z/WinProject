//
//  CHDNetwork.m
//  CHDMovie
//
//  Created by Dean on 14-3-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "CHDNetwork.h"
#import "ASIDownloadCache.h"
#import "NSObject+JSON.h"

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

- (void)createRESTfulRequest:(NSDictionary *)param
{
    [self cancelRequest];
    
    [self ensureRequestContext];
    
    self.request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:REST_API_URL]];
    
    AppDelegate* app = [AppDelegate shareAppDelegate];
    
    NSString* device = [NSString stringWithFormat:@"%@,%@,%@",app.device_.name,app.device_.systemName,app.device_.identifierForVendor.UUIDString];
    [self.request addRequestHeader:@"HTTP-DEVICE" value:device];
    
    if (![NSString isNilOrEmpty:app.userInfo.cookies])
    {
        [self.request addRequestHeader:@"Cookie" value:[NSString stringWithFormat:@"Session=%@",app.userInfo.cookies]];
    }
    
    self.request.requestCookies = [NSMutableArray arrayWithArray:self.app.cookies];
    self.request.useSessionPersistence = YES;
    self.request.timeOutSeconds = 45.0f;
    
    [self addPostValue:param];
    
}

- (void)addPostValue:(NSDictionary *)term
{
    for (NSString *key in term.allKeys)
    {
        [self.request addPostValue:term[key] forKey:key];
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
        
        DLog(@"%@",ser.request.responseString);
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

- (void)startAsynchronousDownloadPicBlock:(void (^)(id))processBlock
                       responseBuildBlock:(id (^)(NSString *))responseBuildBlock
{
    __block CHDNetwork *ser = self;
    
    completionBlock = ^
    {
        processBlock(ser.request);
        ser = nil;
    };
    
    failedBlock = ^
    {
        
        DLog(@"%@",ser.request.responseString);
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
    self.url = [NSURL URLWithString:REST_API_URL];
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
