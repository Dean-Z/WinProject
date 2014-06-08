//
//  WPConversionInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPConversionInfo.h"

@implementation WPConversionInfo

@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    if (_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.producId = [data objectForKey:@"id"];
    self.logo = [data objectForKey:@"logo"];
    self.title = [data objectForKey:@"title"];
    self.desc = [data objectForKey:@"description"];
    self.type = [data objectForKey:@"type"];
    self.coins = [data objectForKey:@"coins"];
    self.amount = [data objectForKey:@"amount"];
    self.remain = [data objectForKey:@"remain"];
    self.status = [data objectForKey:@"status"];
}

@end
