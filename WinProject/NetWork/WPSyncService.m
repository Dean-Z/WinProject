//
//  WPSyncService.m
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSyncService.h"

@implementation WPSyncService

- (void)loginWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock
{
    
    CHDNetwork* network = [[CHDNetwork alloc]init];
    
    network.method = RESTFUL_METHOD_POST;
    
    [network createRESTfulRequest:term];
    
    [network startAsynchronousWithProcessBlock:^(id resp)
     {
         BOOL isSuccend = NO;
         id date = [NSObject toJSONValue:resp];
         if (date)
         {
             if ([date[@"state"] intValue] != 1)
             {
                 [[WPAlertView viewFromXib] showWithMessage:date[@"message"]];
                 processBlock(nil);
             }
             else
             {
                 processBlock(resp);
                 isSuccend = YES;
             }
         }
         
         if (network.request.responseCookies.count != 0 && isSuccend)
         {
             self.app = [AppDelegate shareAppDelegate];
             self.app.cookies = [NSArray arrayWithArray:network.request.responseCookies];
             
             for (NSHTTPCookie* cookie in network.request.responseCookies)
             {
                 if ([[cookie.properties objectForKey:@"Name"] isEqualToString:@"Session"])
                 {
                     AppDelegate* app = [AppDelegate shareAppDelegate];
                     app.userInfo.rowDate = resp;
                     
                     NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
                     [user setObject:resp forKey:ACCOUNT_KEY_ROWDATA];
                     if ([cookie.properties allKeys].count > 0)
                     {
                         app.userInfo.cookies = [cookie.properties objectForKey:@"Value"];
                         [user setObject:[cookie.properties objectForKey:@"Value"] forKey:ACCOUNT_KEY_COOKIE];
                     }
                     [user synchronize];
                 }
             }
         }
         
     } responseBuildBlock:^id(NSString *respText) {
         return respText;
     }];
}

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
                 [[WPAlertView viewFromXib] showWithMessage:date[@"message"]];
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

- (void)downloadImageWithRoute:(NSDictionary*)term Block: (void (^)(id))processBlock
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
