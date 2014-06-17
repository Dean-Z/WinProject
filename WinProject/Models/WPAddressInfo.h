//
//  WPAddressInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPAddressInfo : WPBaseInfo

@property(nonatomic,strong) NSString* address;
@property(nonatomic,strong) NSString* addressId;
@property(nonatomic,strong) NSString* isDefault;

@property(nonatomic,strong) NSDictionary* data;

@end
