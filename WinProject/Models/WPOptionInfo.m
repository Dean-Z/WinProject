//
//  WPOptionInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-6-14.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPOptionInfo.h"

@implementation WPOptionInfo

@synthesize data = _data;

- (void)setData:(NSDictionary *)data
{
    if (_data)
    {
        _data = nil;
    }
    
    _data = data;
    
    self.optionId = [_data objectForKey:@"id"];
    self.title = [_data objectForKey:@"title"];
    self.survey_id = [_data objectForKey:@"survey_id"];
    self.survey_problem_id = [_data objectForKey:@"survey_problem_id"];
    self.times = [_data objectForKey:@"times"];
}

@end
