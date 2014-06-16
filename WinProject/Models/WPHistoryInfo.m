//
//  WPHistoryInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPHistoryInfo.h"

@implementation WPHistoryInfo

@synthesize data = _data;

- (void) setData:(NSDictionary *)data
{
    if (_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.userId = [_data objectForKey:@"user_id"];
    self.coins = [_data objectForKey:@"coins"];
    self.create_time = [_data objectForKey:@"create_time"];
    self.type = [_data objectForKey:@"type"];
    self.goods = [_data objectForKey:@"goods"];
    
}

@end
