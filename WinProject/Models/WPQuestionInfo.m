//
//  WPQuestionInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPQuestionInfo.h"

@implementation WPQuestionInfo

@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    if (_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.questionId = [_data objectForKey:@"id"];
    self.questionTitle = [_data objectForKey:@"title"];
    self.muti = [_data objectForKey:@"muti"];
    self.survey_id = [_data objectForKey:@"survey_id"];
    self.type = [_data objectForKey:@"type"];
    
    NSArray* optionArray = [_data objectForKey:@"options"];
    self.options = [@[] mutableCopy];
    for (NSDictionary* dict in optionArray)
    {
        WPOptionInfo* info = [[WPOptionInfo alloc]init];
        info.data = dict;
        [self.options addObject:info];
        info = nil;
    }
}

@end
