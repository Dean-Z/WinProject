//
//  WPAddressInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAddressInfo.h"

@implementation WPAddressInfo

@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    if (_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.address = [_data objectForKey:@"address"];
    self.isDefault = [_data objectForKey:@"default"];
    self.addressId = [_data objectForKey:@"id"];
}

@end
