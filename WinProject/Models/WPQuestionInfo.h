//
//  WPQuestionInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-6-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@interface WPQuestionInfo : WPBaseInfo

@property(nonatomic,strong) NSString *questionId;
@property(nonatomic,strong) NSString *questionTitle;
@property(nonatomic,strong) NSString *muti;
@property(nonatomic,strong) NSString *survey_id;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSArray *options;

@end
