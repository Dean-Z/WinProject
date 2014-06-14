//
//  WPOptionInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-14.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPOptionInfo : WPBaseInfo

@property(nonatomic,strong) NSString    *optionId;
@property(nonatomic,strong) NSString    *title;
@property(nonatomic,strong) NSString    *survey_id;
@property(nonatomic,strong) NSString    *survey_problem_id;
@property(nonatomic,strong) NSString    *times;

@property(nonatomic,strong) NSDictionary* data;

@end
