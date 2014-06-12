//
//  WPMarketInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

typedef enum
{
    Market_Invite_Type = 1,
    Market_Information_Type = 2,
    Market_Question_Type = 3,
}MarketType;

@interface WPMarketInfo : WPBaseInfo

@property (nonatomic,strong) NSString* cover;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* desc;
@property (nonatomic,strong) NSString* timeLimit;
@property (nonatomic,strong) NSString* coins;
@property (nonatomic,assign) MarketType type;

@end
