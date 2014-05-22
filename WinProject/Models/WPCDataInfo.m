//
//  WPCDataInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-5-21.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPCDataInfo.h"

@implementation WPCBaseDateInfo

- (void)setData:(NSDictionary *)data
{
    if(_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.picId = [data objectForKey:@"id"];
    self.title = [data objectForKey:@"title"];
    self.logo = [data objectForKey:@"logo"];
    self.type = [data objectForKey:@"type"];
    self.url = [data objectForKey:@"url"];
    self.exprie = [data objectForKey:@"exprie"];
    self.copies = [data objectForKey:@"copies"];
    self.remain = [data objectForKey:@"remain"];
    self.coin = [data objectForKey:@"coin"];
    self.status = [data objectForKey:@"status"];
}

@end

@implementation WPCDataInfo
@synthesize rowDate = _rowDate;

- (void)setRowDate:(NSString *)rowDate
{
    if (_rowDate)
    {
        _rowDate = nil;
    }
    
    _rowDate = rowDate;
    
    self.cBaseDateArray = [@[] mutableCopy];
    
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
                    WPCBaseDateInfo* info = [[WPCBaseDateInfo alloc]init];
                    info.data = dict;
                    [self.cBaseDateArray addObject:info];
                }
            }
        }
    }
}

@end
