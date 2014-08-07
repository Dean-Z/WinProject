//
//  Configuration.h
//  Call
//
//  Created by Dean on 13-10-31.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#ifndef Call_Configuration_h
#define Call_Configuration_h

#define REST_API_URL @"http://api.yingping.oneve.com"

#define USER_INFO_ROWDATA       @"USER_INFO_ROWDATA"
#define ACCOUNT_KEY_ROWDATA     @"ACCOUNT_KEY_ROWDATA"
#define ACCOUNT_KEY_COOKIE      @"ACCOUNT_KEY_COOKIE"

#define CORVER_DATA                     @"CORVER_DATA"
#define MARKET_INVITE                   @"MARKET_INVITE"
#define MARKET_INFORMATION              @"MARKET_INFORMATION"

#define UserName                            @"UserName"
#define UserPassword                        @"UserPassword"
#define AppGuide                            @"AppGuide"

typedef enum
{
    VIEW_LOGIN = 1,
    VIEW_RESET_PASSWORD = 2,
    VIEW_RESET_NICKNAME = 3,
    
}ViewType;

#define IS_SYSTEM_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

#define DLog(format, ...) NSLog((@"[LINE: %d]%s: " format), __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__)
#define AS_MESSAGE(o) NSLocalizedString(o, @"")

#define kAppKey         @"3860363964"

#define APP_ID          @"861905235"
#define App_Version     @"1.0"

#define SERVICE_PHONE_NUMBER    @"400399929993"
#define IAD_PHONE_NUMBER        @"021-61318578"
#define CONTENT_US              @""

#define WSinaAppKey         @"2824257247"
#define WSinaSecret         @"9fee95fb8cd104dd516344c4e840f2b6"
#define WSinaRedirectURI    @"http://www.kibey.com"

#define WXAPPKey       @"wx72899e9b506caf7f"
#define CrittercismID  @"539c7d1c83fb796851000006"
#define FlurryID       @"KBNY4SCV8NKKY989SHS6"


#endif
