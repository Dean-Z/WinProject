//
//  WPHistoryInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPHistoryInfo : WPBaseInfo

@property(nonatomic,strong) NSString* userId;
@property(nonatomic,strong) NSString* coins;
@property(nonatomic,strong) NSString* create_time;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* goods;

@property(nonatomic,strong) NSDictionary* data;
@end
