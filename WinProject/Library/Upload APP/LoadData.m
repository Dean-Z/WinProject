//
//  LoadData.m
//  ListDemo
//
//  Created by Dean on 13-10-29.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "LoadData.h"
#import "SBJsonParser.h"

@implementation LoadData

-(void)startAsynchronousWithProcessBlock:(void (^)(id))processBlock urlString:(NSString*)urlString
{
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    __block LoadData* load= self;
    
    completionBlock = ^{
        if (load.request)
        {
            SBJsonParser* parser = [[SBJsonParser alloc]init];
            NSDictionary* dict = [parser objectWithString:load.request.responseString];
            processBlock(dict);
        }
    };
    
    [self.request setCompletionBlock:completionBlock];
    
    [self.request startAsynchronous];
}

@end
