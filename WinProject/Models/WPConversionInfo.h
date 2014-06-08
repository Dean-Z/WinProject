//
//  WPConversionInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPConversionInfo : WPBaseInfo

@property (nonatomic,strong) NSString* cover;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* desc;

@property (nonatomic,strong) NSString* producId;
@property (nonatomic,strong) NSString* logo;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSString* coins;
@property (nonatomic,strong) NSString* amount;
@property (nonatomic,strong) NSString* remain;
@property (nonatomic,strong) NSString* status;

@property (nonatomic,strong) NSDictionary* data;

@end
