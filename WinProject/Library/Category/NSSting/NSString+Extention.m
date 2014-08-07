//
//  NSString+Extention.m
//  shopCart
//
//  Created by Dean on 13-10-13.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "NSString+Extention.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation NSString (Extention)

+ (BOOL)isNilOrEmpty:(NSString *)aNSString
{
	return [aNSString isKindOfClass:[NSNull class]] || !aNSString || aNSString.length == 0;
}
+ (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    
    return platform;
}

- (BOOL) contains:(NSString *) value
{
	NSRange range = [self rangeOfString: value];
	return ( range.location != NSNotFound );
}

-(NSString *)urlEncode {
	return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
	
	
	CFStringRef buffer = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                 (__bridge CFStringRef)self,
                                                                 NULL,
                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
	
	NSString *output = [NSString stringWithFormat:@"%@", buffer];
	
	CFRelease(buffer);
	
	return output;
}


+(NSString*)reMakePath:(NSString*)path
{
    NSMutableString* tmpStr = [NSMutableString stringWithString:path];
    for (NSUInteger i=0; i<[tmpStr length]; i++)
    {
        if ([tmpStr characterAtIndex:i] == '/')
        {
            [tmpStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"_"];
            break;
        }
    }
    return tmpStr;
}

+ (NSString *)randomAlphanumericStringWithLength:(NSInteger)length
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}



+ (NSString *) platformString
{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

+ (BOOL)checkTel:(NSString *)str
{
    
    if ([str length] == 0)
    {
        return NO;
    }
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    BOOL isMatch = [phoneTest evaluateWithObject:str];
    
    if (!isMatch)
    {
        return NO;
    }
    return YES;
}

+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (NSString*)MD5
{
    const char *ptr = [self UTF8String];
    
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

@end;
