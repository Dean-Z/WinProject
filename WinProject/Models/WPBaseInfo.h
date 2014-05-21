//
//  WPBaseInfo.h
//  WinProject
//
//  Created by Dean-Z on 14-5-20.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPBaseInfo : NSObject

@property (nonatomic,strong) NSString* rowDate;

- (void)save:(NSString*)key;

@end
