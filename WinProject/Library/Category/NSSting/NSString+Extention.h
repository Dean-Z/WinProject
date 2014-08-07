//
//  NSString+Extention.h
//  shopCart
//
//  Created by Dean on 13-10-13.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extention)

+ (BOOL)isNilOrEmpty:(NSString *)aNSString;

+ (NSString *) platformString;

- (NSString*)MD5;

+ (BOOL)checkTel:(NSString *)str;
+ (BOOL) validateEmail:(NSString *)email;

- (BOOL) contains:(NSString *) value;

-(NSString *)urlEncode;

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

+ (NSString *)reMakePath:(NSString*)path;

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length;

@end