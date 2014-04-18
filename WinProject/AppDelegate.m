//
//  AppDelegate.m
//  WinProject
//
//  Created by Dean on 14-4-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

+(id)shareAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}


- (void) applicationDidBecomeActive:(UIApplication *)application
{
    if ([self.reachability currentReachabilityStatus] == NotReachable)
    {
        self.isNetworkAvailable = NO;
        DLog(@"NO NETWORK !!!");
    }
}

- (void) handleNetworkChange
{
    
    self.hasNetworkChanged = YES;
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if (remoteHostStatus == NotReachable)
    {
        //show network alert
        self.isNetworkAvailable = NO;
        DLog(@"NO NETWORK !!!");
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        self.isNetworkAvailable = YES;
        DLog(@"NETWORK via WIFI");
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        self.isNetworkAvailable = YES;
        DLog(@"NETWORK via CELL");
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
