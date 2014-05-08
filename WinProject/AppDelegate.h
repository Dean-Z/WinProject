//
//  AppDelegate.h
//  WinProject
//
//  Created by Dean on 14-4-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "RDVTabBarController.h"
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) Reachability* reachability;
@property (nonatomic) BOOL isNetworkAvailable;
@property (nonatomic) BOOL hasNetworkChanged;
@property (strong, nonatomic) UIViewController *viewController;

+(id)shareAppDelegate;

@end
