//
//  WPQDateInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-5-21.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPQDateInfo.h"

@implementation WPQBaseDateInfo

@end

@implementation WPQDateInfo

@synthesize rowDate = _rowDate;

- (void)setRowDate:(NSString *)rowDate
{
    if (_rowDate)
    {
        _rowDate = nil;
    }
    
    _rowDate = rowDate;
    
    self.qBaseDateArray = [@[] mutableCopy];
    
    id date = [NSObject toJSONValue:_rowDate];
    if ([date isKindOfClass:[NSDictionary class]])
    {
        id result = [date objectForKey:@"result"];
        if ([result isKindOfClass:[NSDictionary class]])
        {
            id datas = [result objectForKey:@"data"];
            
            if ([datas isKindOfClass:[NSArray class]])
            {
                for (NSDictionary* dict in datas)
                {
                    WPQBaseDateInfo* info = [[WPQBaseDateInfo alloc]init];
                    info.picId = [dict objectForKey:@"id"];
                    info.title = [dict objectForKey:@"title"];
                    info.logo = [dict objectForKey:@"logo"];
                    info.type = [dict objectForKey:@"type"];
                    info.url = [dict objectForKey:@"url"];
                    info.exprie = [dict objectForKey:@"exprie"];
                    info.copies = [dict objectForKey:@"copies"];
                    info.remain = [dict objectForKey:@"remain"];
                    info.coin = [dict objectForKey:@"coin"];
                    info.status = [dict objectForKey:@"status"];
                    [self.qBaseDateArray addObject:info];
                }
            }
        }
    }
}

@end
