//
//  NSObject+JSON.h
//  FrameworkDemo
//
//  Created by Dean on 14-2-10.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

+ (NSObject*) toJSONValue:(id)resp;

+ (NSString *)toJSONString:(NSObject *)nsObject;
+ (NSObject *)toJSONObject:(NSObject *)nsObject;

+ (id)fromJSONString:(NSString *)jsonString;
+ (id)fromJSONString:(NSString *)jsonString inStore:(IBCoreDataStore *)customStore;

+ (id)fromJSONObject:(NSDictionary *)jsonObject;
+ (id)fromJSONObject:(NSDictionary *)jsonObject inStore:(IBCoreDataStore *)customStore;

+ (NSObject *)createObject:(Class) modelType inStore:(IBCoreDataStore *)customStore;

@end
