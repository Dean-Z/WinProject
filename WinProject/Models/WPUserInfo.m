//
//  WPUserInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-5-20.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPUserInfo.h"

@implementation WPUserInfo

@synthesize rowDate = _rowDate;

- (void) setRowDate:(NSString *)rowDate
{
    if (_rowDate)
    {
        _rowDate = nil;
    }
    
    _rowDate = rowDate;
    
    id date = [NSObject toJSONValue:_rowDate];
    if ([date isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *result = [date objectForKey:@"result"];
        
        if ([result isKindOfClass:[NSDictionary class]])
        {
            self.userId = [date objectForKey:@"id"];
            self.account = [date objectForKey:@"account"];
            self.nickname = [date objectForKey:@"nickname"];
            self.phone = [date objectForKey:@"phone"];
            self.coins = [date objectForKey:@"coins"];
            self.income = [date objectForKey:@"income"];
            self.login_times = [date objectForKey:@"login_times"];
            self.token = [date objectForKey:@"token"];
        }
    }
}

- (void)save:(NSString *)key
{
    [super save:key];
}

@end
