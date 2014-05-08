//
//  WPShareManager.h
//  WinProject
//
//  Created by Dean-Z on 14-5-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"


@interface WPShareManager : NSObject

-(void)shareWithSina:(UIImage*)image message:(NSString*)message;

@end
