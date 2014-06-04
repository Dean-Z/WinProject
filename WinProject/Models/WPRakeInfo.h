//
//  WPRakeInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPRakeInfo : WPBaseInfo

@property (nonatomic,strong) NSString* userId;
@property (nonatomic,strong) NSString* nickname;
@property (nonatomic,strong) NSString* account;
@property (nonatomic,strong) NSString* coins;

@property (nonatomic,strong) NSDictionary* data;
@end
