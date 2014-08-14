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
#import "CCUpdataApp.h"
#import "Crittercism.h"
#import "Flurry.h"
#import "UMSocial.h"
#import "WeiboSDK.h"
#import "UMSocialSinaHandler.h"

@implementation AppDelegate

+(id)shareAppDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    self.device_ = [[UIDevice alloc] init];
    [[CCGetContactPerson shareCCGetContactPerson] cheackGranted];
    
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
    
    if (![self autoLogin])
    {
        [self checkUserInfo];
    }
    
    [self versionCheck];
    
    [self initAnalytics];
    
    [UMSocialData setAppKey:kUMengKey];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:WSinaRedirectURI];
    
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    return YES;
}

- (void)initAnalytics
{
    [Crittercism enableWithAppID:CrittercismID];
    
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:FlurryID];
}

- (void)loginSucceed
{
    [self setupViewControllers];
    self.window.rootViewController = self.viewController;
    
    [self customizeInterface];
    
    [[WPAlertView viewFromXib]showWithMessage:@"登陆成功"];
}

- (void)logoutSucceed:(BOOL)showKeyboard
{
    LoginViewController* login = [[LoginViewController alloc]viewControllerFromXib];
    login.showKeyBoard = showKeyboard;
    self.window.rootViewController = login;
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
    
    self.aTabBarController = [[RDVTabBarController alloc] init];
    self.aTabBarController.delegate = self;
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:self.aTabBarController];
    [nav.navigationBar setHidden:YES];
    
    [self.aTabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,fouthNavigationController]];
    self.viewController = nav;
    
    [self customizeTabBarForController:self.aTabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         };
        item.unselectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                         };
        
        item.titlePositionAdjustment = UIOffsetMake(0, 6);
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        
        index++;
    }
    
    RDVTabBarItem* item1 = [[[tabBarController tabBar] items] objectAtIndex:0];
    UIImage* item1_image = [UIImage imageNamed:@"schedule"];
    [item1 setFinishedSelectedImage:item1_image withFinishedUnselectedImage:item1_image];
    
    RDVTabBarItem* item2 = [[[tabBarController tabBar] items] objectAtIndex:1];
    UIImage* item2_image = [UIImage imageNamed:@"market"];
    [item2 setFinishedSelectedImage:item2_image withFinishedUnselectedImage:item2_image];
    
    RDVTabBarItem* item3 = [[[tabBarController tabBar] items] objectAtIndex:2];
    UIImage* item3_image = [UIImage imageNamed:@"shopping-bag"];
    [item3 setFinishedSelectedImage:item3_image withFinishedUnselectedImage:item3_image];
    
    RDVTabBarItem* item4 = [[[tabBarController tabBar] items] objectAtIndex:3];
    UIImage* item4_image = [UIImage imageNamed:@"setting"];
    [item4 setFinishedSelectedImage:item4_image withFinishedUnselectedImage:item4_image];
    
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

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if ([viewController.title isEqualToString:@"收钱柜"])
    {
        UINavigationController* nav = (UINavigationController*)viewController;
        WPWalletViewController* wallet = nav.viewControllers[0];
        [wallet updateUserInfo];
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


-(void)versionCheck
{
    [[CCUpdataApp alloc]detectionIfNewVersion:^(id resp) {
        if (resp !=nil && [resp isKindOfClass:[NSDictionary class]])
        {
            NSArray* tmpArray = [resp objectForKey:@"results"];
            if (tmpArray !=nil && tmpArray.count > 0)
            {
                NSDictionary* result = tmpArray[0];
                
                NSString* version = [result objectForKey:@"version"];
                
                if (![version isEqualToString:App_Version])
                {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"更新" message:[NSString stringWithFormat:@"最新版本%@",[result objectForKey:@"version"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                    self.urlString  = [result objectForKey:@"trackViewUrl"];
                    [alert show];
                    alert = nil;
                }
                
            }
        }
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (![NSString isNilOrEmpty:self.urlString])
        {
            [[CCUpdataApp alloc]update:self.urlString];
        }
    }
}

- (void)checkUserInfo
{
    self.userInfo = [[WPUserInfo alloc]init];
//    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
//    NSString* userRowDate = [userDefault objectForKey:USER_INFO_ROWDATA];
//    
//    if ([NSString isNilOrEmpty:userRowDate])
//    {
//        [self.userInfo setRowDate:userRowDate];
//        [self loginSucceed];
//    }
//    else
//    {
        [self logoutSucceed:YES];
//    }
}

- (BOOL)autoLogin
{
    BOOL canAutoLogin = NO;
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    
    NSString* phone = [user objectForKey:UserName];
    NSString* password = [user objectForKey:UserPassword];
    
    if ([NSString isNilOrEmpty:phone])
    {
        return canAutoLogin;
    }
    
    canAutoLogin = YES;
    
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:self.window.bounds];
    self.backgroundImageView.image = [UIImage imageNamed:@"view_bg.png"];
    [self.window addSubview:self.backgroundImageView];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    NSMutableDictionary* dict = [@{@"app":@"index",@"act":@"login"} mutableCopy];
    [dict setValue:phone forKey:@"account"];
    [dict setValue:[password MD5] forKey:@"password"];
    
    [[WPSyncService alloc]loginWithRoute:dict Block:^(id resp)
     {
         if (resp)
         {
            self.userInfo = [[WPUserInfo alloc]init];
            self.phoneNumber = phone;
            [self.userInfo setRowDate:resp];
            [self.userInfo save:USER_INFO_ROWDATA];
             
            [self setupViewControllers];
            self.window.rootViewController = self.viewController;
            [self customizeInterface];
         }
         else
         {
             [self logoutSucceed:YES];
         }
         [self.backgroundImageView removeFromSuperview];
         [SVProgressHUD dismiss];
     }];
    return canAutoLogin;
}

- (void)saveUserPhone:(NSString*)phone password:(NSString*)password
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:phone forKey:UserName];
    [user setObject:password forKey:UserPassword];
    [user synchronize];
}

- (void)removeUserInfoMessage
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"" forKey:UserName];
    [user setObject:@"" forKey:UserPassword];
    [user synchronize];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString* token = [deviceToken description];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:token forKey:DeviceToken];
    [user synchronize];
    
//    [BPush registerDeviceToken:deviceToken]; // 必须
//    
//    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
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
