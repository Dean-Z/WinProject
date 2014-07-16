//
//  LoginViewController.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "LoginViewController.h"
#import "WPGuideView.h"

#define InputAccessory IS_IPHONE_5? 0 : 50

@interface LoginViewController ()
{
    WPSigninView* signinView;
    WPSignupView* signupView;
    WPAuthView*   authView;
    WPPasswordView* password;
    WPNickName*   nickView;
    WPRegisterAlert* alertView;
    WPGuideView* guideView;
    
    NSString* phoneNumber;
    NSString* passwordString;
    NSString* authCode;
    
    BOOL isShowKeyBoard;
    BOOL isFindPassword;
    
}

@property(nonatomic,assign,getter = isFindPassword) BOOL forFindPassword;

@end

@implementation LoginViewController

@synthesize forFindPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (self.viewType)
    {
        case VIEW_RESET_PASSWORD:
        {
            [self prepareResetPasswordOnly];
        }
            break;
        case VIEW_RESET_NICKNAME:
        {
            [self prepareResetNickNameOnly];
        }
            break;
        default:
        {
            [self prepareSigninView];
        }
            break;
    }
    
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    
    if([NSString isNilOrEmpty:[user objectForKey:AppGuide]])
    {
        [self prepareGuide];
        [user setObject:AppGuide forKey:AppGuide];
        [user synchronize];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)prepareResetPasswordOnly
{
    if (password == nil)
    {
        password = [WPPasswordView viewFromXib];
        password.viewType = self.viewType;
        password.delegate = self;
        [password renderView];
        password.originX = (self.view.sizeW - password.sizeW)/2;
        password.originY = (self.view.sizeH - password.sizeH)/2;
        password.originY -= InputAccessory;
        [self.view addSubview:password];
    }
    
    [password.password_1 becomeFirstResponder];
}

- (void)prepareResetNickNameOnly
{
    if (nickView == nil)
    {
        nickView = [WPNickName viewFromXib];
        nickView.delegate = self;
        [nickView renderView];
        nickView.originX = (self.view.sizeW - nickView.sizeW)/2;
        nickView.originY = (self.view.sizeH - nickView.sizeH)/2 - 50;
        [self.view addSubview:nickView];
    }
    
    [nickView.nickTextField becomeFirstResponder];
}


- (void)keyboardDidShow
{
    isShowKeyBoard = YES;
    [UIView transitionWithView:signinView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (signinView)
            signinView.originY -= InputAccessory;
        if (signupView)
            signupView.originY -= InputAccessory;
        if (authView)
            authView.originY -= InputAccessory;
        if (nickView)
            nickView.originY -= InputAccessory;
            
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardDidHidden
{
    isShowKeyBoard = NO;
    [UIView transitionWithView:signinView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (signinView)
            signinView.originY += InputAccessory;
        if (signupView)
            signupView.originY += InputAccessory;
        if (authView)
            authView.originY += InputAccessory;
        if (nickView)
            nickView.originY += InputAccessory;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)prepareSigninView
{
    if (signinView == nil)
    {
        signinView = [WPSigninView viewFromXib];
        [signinView renderView];
        signinView.delegate = self;
        signinView.centerX = self.view.centerX;
        signinView.originY = (self.view.sizeH - signinView.sizeH)/2 - 50;
        [self.view addSubview:signinView];
        
        if (self.showKeyBoard)
        {
            [signinView.phoneTextField becomeFirstResponder];
        }
    }
}

- (void)prepareSignupView:(BOOL)isFind
{
    if (signupView == nil)
    {
        signupView = [WPSignupView viewFromXib];
        signupView.isFindPassword = isFind;
        isFindPassword = isFind;
        [signupView renderView];
        signupView.delegate = self;
        signupView.originX = self.view.sizeW;
        signupView.originY = (self.view.sizeH - signupView.sizeH)/2 - 50;
        [self.view addSubview:signupView];
    }
    
    [signupView.phoneTextField becomeFirstResponder];
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        signupView.originX = (self.view.sizeW - signupView.sizeW)/2;
        signinView.originX = -signinView.sizeW;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)prepareAuthView
{
    if (authView == nil)
    {
        authView = [WPAuthView viewFromXib];
        authView.delegate = self;
        authView.phoneNumebrString = phoneNumber;
        [authView renderView];
        authView.originY = (self.view.sizeH - authView.sizeH)/2 - 50;
        
        authView.originX = self.view.sizeW;
         [self.view addSubview:authView];
    }
    
    [authView.authCodeTextField becomeFirstResponder];
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        authView.originX = (self.view.sizeW - signupView.sizeW)/2;
        signupView.originX = -signinView.sizeW - 50;
        signinView.originX = -signinView.sizeW;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)preparePasswordView
{
    if (password == nil)
    {
        password = [WPPasswordView viewFromXib];
        password.delegate = self;
        [password renderView];
        password.originX = self.view.sizeW;
        password.originY = (self.view.sizeH - password.sizeH)/2;
        password.originY -= InputAccessory;
        [self.view addSubview:password];
    }
    
    [password.password_1 becomeFirstResponder];
    [UIView transitionWithView:password duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        password.originX = (self.view.sizeW - signupView.sizeW)/2;
        authView.originX = -authView.sizeW;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)prepareNickView
{
    if (nickView == nil)
    {
        nickView = [WPNickName viewFromXib];
        nickView.delegate = self;
        [nickView renderView];
        nickView.originX = self.view.sizeW;
        nickView.originY = (self.view.sizeH - nickView.sizeH)/2 - 50;
        [self.view addSubview:nickView];
    }
    
    [nickView.nickTextField becomeFirstResponder];
    [UIView transitionWithView:password duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        nickView.originX = (self.view.sizeW - signupView.sizeW)/2;
        password.originX = -password.sizeW;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)parpareAlertView
{
    if (alertView == nil)
    {
        alertView = [WPRegisterAlert viewFromXib];
        alertView.delegate = self;
        [alertView renderView];
    }
}

#pragma mark SIGN DELEGATE

- (void) signRegister
{
    self.forFindPassword = NO;
    [self prepareSignupView:NO];
}

- (void) signinSucceed
{
     [self.app loginSucceed];
}

- (void) findPassword
{
    self.forFindPassword = YES;
    [self prepareSignupView:YES];
}

- (void) signupBackAction
{
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        signinView.originX = (self.view.sizeW - signinView.sizeW)/2;
        signupView.originX = self.view.sizeW;
    } completion:^(BOOL finished) {
        [signupView removeFromSuperview];
        signupView = nil;
    }];
}

- (void) signupWithNumber:(NSString *)number
{
    phoneNumber = number;
    
    [self prepareAuthView];
}


- (void)authBack
{
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        authView.originX = self.view.sizeW;
        signupView.originX = (self.view.sizeW - signupView.sizeW)/2;
        signinView.originX = -signinView.sizeW;
    } completion:^(BOOL finished) {
        [authView removeFromSuperview];
        authView = nil;
    }];
}

- (void)authSucceed:(NSString *)aAuthCode
{
    authCode = aAuthCode;
    [self preparePasswordView];
}


- (void)passwordBack
{
    if (self.viewType == VIEW_RESET_PASSWORD)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    [UIView transitionWithView:password duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        password.originX = self.view.sizeW;
        signupView.originX = self.view.sizeW;
        signinView.originX = (self.view.sizeW - signupView.sizeW)/2;
    } completion:^(BOOL finished) {
        [authView removeFromSuperview];
        [password removeFromSuperview];
        password = nil;
        authView = nil;
    }];
}

- (void)passwordSucceed:(NSString *)aPassword
{
    if (self.forFindPassword)
    {
        [self.view setUserInteractionEnabled:NO];
        [[WPSyncService alloc]syncWithRoute:@{@"app":@"index",
                                             @"act":@"forgetPwd",
                                             @"phone":phoneNumber,
                                             @"code":authCode,
                                             @"password":[aPassword MD5]} Block:^(id resp) {
                                                 if (resp)
                                                 {
                                                     [[WPAlertView viewFromXib] showWithMessage:@"修改成功,请重新登陆！"];
                                                     ;
                                                     [self passwordBack];
                                                     self.forFindPassword = NO;
                                                     [self.view setUserInteractionEnabled:YES];
                                                 }
                                             }];
        return;
    }
    
    if (self.viewType == VIEW_RESET_PASSWORD)
    {
        [self.view setUserInteractionEnabled:NO];
        [[WPSyncService alloc]syncWithRoute:@{@"app":@"user",
                                              @"act":@"pwd",
                                              @"password":[aPassword MD5]} Block:^(id resp) {
                                                  if (resp)
                                                  {
                                                      [[WPAlertView viewFromXib] showWithMessage:@"修改成功"];
                                                      NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
                                                      [user setObject:aPassword forKey:UserPassword];
                                                      [user synchronize];
                                                  }
                                                  [self.navigationController popViewControllerAnimated:YES];
                                                  [self.view setUserInteractionEnabled:YES];
                                              }];
        return;
    }
    
    passwordString = aPassword;
    
    [self prepareNickView];
}

- (void)nickNameBack
{
    if (self.viewType == VIEW_RESET_NICKNAME)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        password.originX = self.view.sizeW;
        nickView.originX = self.view.sizeW;
        signupView.originX = self.view.sizeW;
        signinView.originX = (self.view.sizeW - signupView.sizeW)/2;
    } completion:^(BOOL finished) {
        [authView removeFromSuperview];
        [password removeFromSuperview];
        [nickView removeFromSuperview];
        nickView = nil;
        password = nil;
        authView = nil;
    }];
}

- (void)nickNameCompliation:(NSString *)nickName
{
    if (self.viewType == VIEW_RESET_NICKNAME)
    {
        [[WPSyncService alloc]syncWithRoute:@{@"app":@"user",
                                              @"act":@"update",
                                              @"nickname":nickName} Block:^(id resp) {
                                                  if (resp)
                                                  {
                                                      [[WPAlertView viewFromXib] showWithMessage:@"修改成功"];
                                                      self.app.userInfo.nickname = nickName;
                                                  }
                                                  [self.navigationController popViewControllerAnimated:YES];
                                              }];
        return;
    }
    
    NSDictionary* term = @{@"app":@"index",
                           @"act":@"register",
                           @"phone":phoneNumber,
                           @"password":[passwordString MD5],
                           @"code":authCode};
    if (isFindPassword)
    {
        [term setValue:@"ForgetPwd" forKey:@"act"];
    }
    
    [[WPSyncService alloc]syncWithRoute:term Block:^(id resp) {
        if (![NSString isNilOrEmpty:resp])
        {
            [self parpareAlertView];
        }
    }];
}

- (void)registerSucceed
{
    [self nickNameBack];
}


- (void)prepareGuide
{
    if (guideView == nil)
    {
        [signinView.phoneTextField resignFirstResponder];
        guideView = [WPGuideView viewFromXib];
        [guideView renderView];
        [self.view addSubview:guideView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
