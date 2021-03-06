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
    
    __weak WPSyncService *weakSelf = self;
    [network startAsynchronousWithProcessBlock:^(id resp)
     {
         BOOL isSuccend = NO;
         id date = [NSObject toJSONValue:resp];
         self.app = [AppDelegate shareAppDelegate];
         if (date)
         {
             if ([date[@"state"] intValue] != 1)
             {
                 NSString* message = [date[@"message"] lowercaseString];
                 
                 if ([message isEqualToString:@"not login!"])
                 {
                 }
                 else
                 {
                     [[WPAlertView viewFromXib] showWithMessage:date[@"message"]];
                     processBlock(nil);
                 }
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
         
         [weakSelf postDeviceToken];
         
     } responseBuildBlock:^id(NSString *respText) {
         return respText;
     }];
}

- (void) postDeviceToken
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *token = [user objectForKey:DeviceToken];
    if (token) {
        NSMutableDictionary* dict = [@{@"app":@"index",@"act":@"CreatePushToken",@"push_token":token} mutableCopy];
        [self syncWithRoute:dict Block:^(id resp) {
            if (resp) {
                
            }
        }];
    }
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
                 NSString* message = date[@"message"];
                 if ([message isEqualToString:@"Not Login!"])
                 {
//                     [[WPAlertView viewFromXib] showWithMessage:@"网络链接错误，请重新登陆！"];
                 }
                 else
                 {
                     [[WPAlertView viewFromXib] showWithMessage:date[@"message"]];
                     processBlock(nil);
                 }
             }
             else
             {
                 [self saveCookie:network];
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
    
    [network startAsynchronousDownloadPicBlock:^(id respData)
    {
        processBlock(respData);
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

- (void) saveCookie:(CHDNetwork*)network
{
    if (network.request.responseCookies.count != 0)
    {
        self.app = [AppDelegate shareAppDelegate];
        self.app.cookies = [NSArray arrayWithArray:network.request.responseCookies];
        
        for (NSHTTPCookie* cookie in network.request.responseCookies)
        {
            if ([[cookie.properties objectForKey:@"Name"] isEqualToString:@"Session"])
            {
                AppDelegate* app = [AppDelegate shareAppDelegate];
                
                NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
                if ([cookie.properties allKeys].count > 0)
                {
                    app.userInfo.cookies = [cookie.properties objectForKey:@"Value"];
                    [user setObject:[cookie.properties objectForKey:@"Value"] forKey:ACCOUNT_KEY_COOKIE];
                }
                [user synchronize];
            }
        }
    }
}

@end
