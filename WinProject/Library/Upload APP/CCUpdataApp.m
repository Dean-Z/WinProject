//
//  CCUpdataApp.m
//  QCall
//
//  Created by Dean on 13-11-1.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "CCUpdataApp.h"

@implementation CCUpdataApp

-(void)takeStar
{
    NSString  * nsStringToOpen = [NSString  stringWithFormat: @"%@%@",GET_STAR,APP_ID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
}

-(void)update:(NSString*)url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(void)detectionIfNewVersion:(void (^)(id))processBlock
{
    [[[LoadData alloc]init]startAsynchronousWithProcessBlock:^(id resp)
    {
        processBlock(resp);
    } urlString:[NSString stringWithFormat:@"%@%@",DETECTION_VERSION,APP_ID]];
}

-(void)goAppStore
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTORE]];
}



@end
