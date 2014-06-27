//
//  WPUserInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-5-20.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPUserInfo : WPBaseInfo

@property (nonatomic,strong) NSString* cookies;

@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong) NSString* account;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,strong) NSString* coins;
@property (nonatomic,strong) NSString* income;
@property (nonatomic,strong) NSString* login_times;
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString* complete;

@end
