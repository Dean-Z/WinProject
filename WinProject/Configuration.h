//
//  Configuration.h
//  Call
//
//  Created by Dean on 13-10-31.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#ifndef Call_Configuration_h
#define Call_Configuration_h

#define REST_API_URL @"http://dev.chdbits.org"

#define ACCOUNT_KEY_ROWDATA         @"ACCOUNT_KEY_ROWDATA"
#define ACCOUNT_KEY_COOKIE          @"ACCOUNT_KEY_COOKIE"

#define IS_SYSTEM_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

#define DLog(format, ...) NSLog((@"[LINE: %d]%s: " format), __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__)
#define AS_MESSAGE(o) NSLocalizedString(o, @"")

#define kAppKey         @"3860363964"

#endif
