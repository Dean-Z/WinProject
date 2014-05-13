//
//  LoadData.h
//  ListDemo
//
//  Created by Dean on 13-10-29.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"

@interface LoadData : NSObject<ASIHTTPRequestDelegate>
{
    ASIBasicBlock completionBlock;
    ASIBasicBlock failedBlock;
}

@property (nonatomic,strong) ASIHTTPRequest* request;

-(void)startAsynchronousWithProcessBlock:(void (^)(id))processBlock urlString:(NSString*)urlString;

@end
