//
//  WPBaseInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-5-20.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseInfo.h"

@implementation WPBaseInfo

- (void)save:(NSString *)key
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    
    [user setValue:self.rowDate forKey:key];
    
    [user synchronize];
}

@end
