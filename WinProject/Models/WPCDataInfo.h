//
//  WPCDataInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-5-21.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPCBaseDateInfo : NSObject

@property(nonatomic,strong) NSString* picId;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* logo;
@property(nonatomic,strong) NSString* type;
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* exprie;
@property(nonatomic,strong) NSString* copies;
@property(nonatomic,strong) NSString* remain;
@property(nonatomic,strong) NSString* coin;
@property(nonatomic,strong) NSString* status;

@property(nonatomic,strong) NSDictionary* data;

@end

@interface WPCDataInfo : WPBaseInfo

@property(nonatomic,strong) NSMutableArray* cBaseDateArray;

@end
