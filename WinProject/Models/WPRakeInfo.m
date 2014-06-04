//
//  WPRakeInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPRakeInfo.h"

@implementation WPRakeInfo

@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    if (_data) {
        _data = nil;
    }
    _data = data;
    
    self.userId = [data objectForKey:@"id"];
    self.nickname = [data objectForKey:@"nickname"];
    self.account = [data objectForKey:@"account"];
    self.coins = [data objectForKey:@"coins"];
}

@end
