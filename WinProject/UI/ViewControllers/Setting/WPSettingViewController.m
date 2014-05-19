//
//  WPSettingViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSettingViewController.h"
#import "CCUpdataApp.h"
#import "LoginViewController.h"

@interface WPSettingViewController ()

@end

@implementation WPSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.scrollViewContainer setContentSize:CGSizeMake(0, self.view.sizeH-64)];
    
    [self makeCornerRadiusAtView:self.cell2Container];
    [self makeCornerRadiusAtView:self.cell3Container];
}

- (void) makeCornerRadiusAtView:(UIView*)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3.0f;
}

- (IBAction)resetPassword:(id)sender
{
    LoginViewController* login = [[LoginViewController alloc]viewControllerFromXib];
    login.viewType = VIEW_RESET_PASSWORD;
    [self.app.aTabBarController.navigationController pushViewController:login animated:YES];
    
    [self.tabBarController hidesBottomBarWhenPushed];
}

- (IBAction)resetName:(id)sender
{
    LoginViewController* login = [[LoginViewController alloc]viewControllerFromXib];
    login.viewType = VIEW_RESET_NICKNAME;
    [self.app.aTabBarController.navigationController pushViewController:login animated:YES];
    
    [self.tabBarController hidesBottomBarWhenPushed];
}

- (IBAction)callServe:(id)sender
{
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",SERVICE_PHONE_NUMBER];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)checkUpdate:(id)sender
{
    [self versionCheck];
}

- (IBAction)aboutUs:(id)sender
{
    
}

- (IBAction)callForIAd:(id)sender
{
    NSString *telUrl = [NSString stringWithFormat:@"telprompt:%@",IAD_PHONE_NUMBER];
    NSURL *url = [[NSURL alloc] initWithString:telUrl];
    [[UIApplication sharedApplication] openURL:url];
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
                else
                {
                    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"当前为最新版本"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
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

- (IBAction)logout:(id)sender
{
    [self.app logoutSucceed:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
