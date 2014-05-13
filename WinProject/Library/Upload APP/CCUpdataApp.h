//
//  CCUpdataApp.h
//  QCall
//
//  Created by Dean on 13-11-1.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadData.h"

#define GET_STAR            @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="

#define DETECTION_VERSION   @"http://itunes.apple.com/lookup?id="

#define APPSTORE            @"https://itunes.apple.com/cn/app/avatar-diy/id791062585?mt=8"

#define MOREAPPURL_US          @"https://itunes.apple.com/us/app/arithmeticgenius/id831685954?ls=1&mt=8"
#define MOREAPPURL_CN          @"https://itunes.apple.com/cn/app/arithmeticgenius/id831685954?ls=1&mt=8"

@interface CCUpdataApp : NSObject

-(void)takeStar;

-(void)update:(NSString*)url;

-(void)detectionIfNewVersion:(void (^)(id))processBlock;

-(void)goAppStore;

-(void)moreGame;

@end
