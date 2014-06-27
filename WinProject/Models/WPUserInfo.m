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
            self.userId = [result objectForKey:@"id"];
            self.account = [result objectForKey:@"account"];
            self.nickname = [result objectForKey:@"nickname"];
            self.phone = [result objectForKey:@"phone"];
            self.coins = [result objectForKey:@"coins"];
            self.income = [result objectForKey:@"income"];
            self.login_times = [result objectForKey:@"login_times"];
            self.token = [result objectForKey:@"token"];
            self.complete = [result objectForKey:@"complete"];
        }
    }
}

- (void)save:(NSString *)key
{
    [super save:key];
}

@end
