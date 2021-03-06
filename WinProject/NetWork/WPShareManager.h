//
//  WPShareManager.h
//  WinProject
//
//  Created by Dean-Z on 14-5-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "WXApi.h"

@interface WPShareManager : NSObject

-(BOOL)shareWithSina:(UIImage*)image message:(NSString*)message;

- (void)shareWithTCWeiBo:(UIViewController*)viewController image:(UIImage*)image;

- (void)shareWithWx:(enum WXScene)scene;

- (void)shareSinaWithUM:(UIViewController *)viewController image:(UIImage *)image;

@end
