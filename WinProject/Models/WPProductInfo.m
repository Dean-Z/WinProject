//
//  WPProductInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-5-26.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPProductInfo.h"

@implementation WPProductInfo

@synthesize rowDate = _rowDate;

-(void)setRowDate:(NSString *)rowDate
{
    if (_rowDate)
    {
        _rowDate = nil;
    }
    _rowDate = rowDate;
    
    id data = [NSObject toJSONValue:_rowDate];
    
    if ([data isKindOfClass:[NSDictionary class]])
    {
        id result = [data objectForKey:@"result"];
        if ([result isKindOfClass:[NSDictionary class]])
        {
            self.picId = [result objectForKey:@"id"];
            self.title = [result objectForKey:@"title"];
            self.type = [result objectForKey:@"type"];
            self.url = [result objectForKey:@"url"];
            self.exprie = [result objectForKey:@"exprie"];
            self.copies = [result objectForKey:@"copies"];
            self.remain = [result objectForKey:@"remain"];
            self.coin = [result objectForKey:@"coin"];
            self.status = [result objectForKey:@"status"];
            self.description = [result objectForKey:@"description"];
            self.brand_id = [result objectForKey:@"brand_id"];
            self.download = [result objectForKey:@"download"];
            self.use = [result objectForKey:@"use"];
        }
    }

}

@end
