//
//  QQImageView.m
//  ListDemo
//
//  Created by Dean on 13-10-30.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "QQImageView.h"

@implementation QQImageView

-(id)init
{
    if (self= [super init])
    {
        self.loadState = IMAGE_NA;
    }
    return self;
}

-(void)setImageUrl:(NSURL *)imageUrl DefaultImage:(UIImage*)defaultImage
{
    if (imageUrl == nil || [imageUrl isEqual:[NSNull null]]) return;
	if ([imageUrl.absoluteString isEqual:@""]) return;
    
    self.imageUrl = nil;
    self.image = defaultImage;
    self.imageUrl = imageUrl;
    
    [self startLoad:self.imageUrl];
}

-(void)setImageUrl:(NSURL *)url
{
    if (url == nil || [url isEqual:[NSNull null]]) return;
	if ([url.absoluteString isEqual:@""]) return;
    
    _imageUrl = nil;
    _imageUrl = url;
    
    [self startLoad:_imageUrl];
}

-(void)startLoad:(NSURL*)url
{
    NSData *cacheImageData = [[ASIDownloadCache sharedCache] cachedResponseDataForURL:url];
    if (cacheImageData != nil)
    {
        self.image = [UIImage imageWithData:cacheImageData];
        return;
    }
    
    if (self.imageRequest)
    {
        [self.imageRequest cancel];
    }
    self.imageRequest = nil;
    
    self.imageRequest = [ASIHTTPRequest requestWithURL:url];
    self.imageRequest.delegate = self;
    self.imageRequest.timeOutSeconds = 60;
    self.imageRequest.cacheStoragePolicy=ASICachePermanentlyCacheStoragePolicy;
    self.imageRequest.downloadCache = [ASIDownloadCache sharedCache];
    [self.imageRequest startAsynchronous];
    
    self.loadState = IMAGE_LOADING;
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    self.image = [UIImage imageWithData:request.responseData];
    self.imageRequest = nil;
    
    self.loadState = IMAGE_DONE;
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    self.loadState = IMAGE_LOADFAIL;
}

@end
