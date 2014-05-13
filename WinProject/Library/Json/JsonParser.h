//
//  JsonParser.h
//  FrameworkDemo
//
//  Created by Dean on 14-2-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+(id)parserWithJsonData:(NSData*)jsonData;

+(NSString*)stringFromJsonData:(id)data;

@end
