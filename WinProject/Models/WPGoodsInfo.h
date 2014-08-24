//
//  WPGoodsInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-8-24.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPGoodsInfo : WPBaseInfo

@property (nonatomic , strong) NSString *title;
@property (nonatomic , strong) NSString *logo;
@property (nonatomic , strong) NSString *type;
@property (nonatomic , strong) NSString *description;
@property (nonatomic , strong) NSString *coins;
@property (nonatomic , strong) NSString *amount;
@property (nonatomic , strong) NSString *remain;
@property (nonatomic , strong) NSString *status;

@property (nonatomic , strong) NSDictionary *goodsMapping;
@end
