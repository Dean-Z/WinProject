//
//  WPSyncService.m
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSyncService.h"


@implementation WPSyncService

- (void) syncWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock
{
    CHDNetwork* network = [[CHDNetwork alloc]init];
    
    network.method = RESTFUL_METHOD_POST;
    
    [network createRESTfulRequest:term];
    
    [network startAsynchronousWithProcessBlock:^(id resp)
     {
         id date = [NSObject toJSONValue:resp];
         if (date)
         {
             if ([date[@"state"] intValue] != 1)
             {
                 Alert(date[@"message"]);
                 processBlock(nil);
             }
             else
             {
                 processBlock(resp);
             }
         }
         
         DLog(@"%@",resp);
         
     } responseBuildBlock:^id(NSString *respText) {
         return respText;
     }];
}

- (NSString*)routeWithTerm:(NSDictionary*)term
{
    
    if ([term allKeys].count==0||term==nil) return @"";
    
    NSString* resultString = @"";
    
    for (NSString* keys in [term allKeys])
    {
        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"/%@",keys]];
        resultString = [resultString stringByAppendingString:[NSString stringWithFormat:@"/%@",[term objectForKey:keys]]];
    }
    return resultString;
}

@end
