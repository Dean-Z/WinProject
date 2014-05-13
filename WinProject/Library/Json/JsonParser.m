//
//  JsonParser.m
//  FrameworkDemo
//
//  Created by Dean on 14-2-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "JsonParser.h"
#import "NSObject+SBJSON.h"

@implementation JsonParser

+(id)parserWithJsonData:(NSData*)jsonData
{
    NSError *error;
    id Dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    return Dic;
}

+(NSString*)stringFromJsonData:(id)data
{
    return [data JSONRepresentation];
}

@end
