//
//  AppDelegate.m
//  WinProject
//
//  Created by Dean on 14-4-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "AppDelegate.h"
#import "WPBuffetViewController.h"
#import "WPSettingViewController.h"
#import "WPMarketViewController.h"
#import "WPWalletViewController.h"
#import "RDVTabBarItem.h"
#import "LoginViewController.h"

@implementation AppDelegate

+(id)shareAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isNetworkAvailable = YES;
    self.hasNetworkChanged  = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNetworkChange)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self setReachability:[Reachability reachabilityForInternetConnection]];
    [self.reachability startNotifier];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setupViewControllers];
    
//    self.viewController = [[LoginViewController alloc]viewControllerFromXib];
    
    self.window.rootViewController = self.viewController;
    
    [self customizeInterface];
    
    return YES;
}


#pragma mark - Methods

- (void)setupViewControllers
{
    UIViewController *wallet = [[WPWalletViewController alloc] viewControllerFromXib];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:wallet];
    
    UIViewController *buffet = [[WPBuffetViewController alloc] viewControllerFromXib];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:buffet];
    
    UIViewController *market = [[WPMarketViewController alloc] viewControllerFromXib];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:market];
    
    UIViewController *setting = [[WPSettingViewController alloc] viewControllerFromXib];
    UIViewController *fouthNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:setting];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,fouthNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third",@"fouth"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         };
        item.unselectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:12],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         };
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        if (index == 3)
        {
            UIImage* image = [UIImage imageNamed:@"fouth"];
            [item setFinishedSelectedImage:image withFinishedUnselectedImage:image];
            return;
        }
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_tall"]
                                      forBarMetrics:UIBarMetricsDefault];
    } else {
        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"navigationbar_background"]
                                      forBarMetrics:UIBarMetricsDefault];
        
        NSDictionary *textAttributes = nil;
        
        if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0) {
            textAttributes = @{
                               NSFontAttributeName: [UIFont boldSystemFontOfSize:20],
                               NSForegroundColorAttributeName: [UIColor whiteColor],
                               };
        } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
            textAttributes = @{
                               UITextAttributeFont: [UIFont boldSystemFontOfSize:20],
                               UITextAttributeTextColor: [UIColor blackColor],
                               UITextAttributeTextShadowColor: [UIColor clearColor],
                               UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                               };
#endif
        }
        
        [navigationBarAppearance setTitleTextAttributes:textAttributes];
    }
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
