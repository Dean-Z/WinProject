//
//  LoginViewController.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    WPSigninView* signinView;
    WPSignupView* signupView;
    WPAuthView*   authView;
    WPPasswordView* password;
    WPNickName*   nickView;
    WPRegisterAlert* alertView;
    
    NSString* phoneNumber;
    BOOL isShowKeyBoard;
}
@end

@implementation LoginViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHidden)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self prepareSigninView];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)keyboardDidShow
{
    isShowKeyBoard = YES;
    [UIView transitionWithView:signinView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (signinView)
            signinView.originY -= 100;
        if (signupView)
            signupView.originY -= 100;
        if (authView)
            authView.originY -= 100;
        if (nickView)
            nickView.originY -= 100;
            
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardDidHidden
{
    isShowKeyBoard = NO;
    [UIView transitionWithView:signinView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (signinView)
            signinView.originY += 100;
        if (signupView)
            signupView.originY += 100;
        if (authView)
            authView.originY += 100;
        if (nickView)
            nickView.originY += 100;
        
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
        signinView.center = self.view.center;
        [self.view addSubview:signinView];
        
        if (self.showKeyBoard)
        {
            [signinView.phoneTextField becomeFirstResponder];
        }
    }
}

- (void)prepareSignupView
{
    if (signupView == nil)
    {
        signupView = [WPSignupView viewFromXib];
        [signupView renderView];
        signupView.delegate = self;
        signupView.originX = self.view.sizeW;
        signupView.originY = (self.view.sizeH - signupView.sizeH)/2;
        if (isShowKeyBoard)
        {
            signupView.originY -= 100;
        }
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
        authView.originY = (self.view.sizeH - authView.sizeH)/2;
        if (isShowKeyBoard)
        {
            authView.originY -= 100;
        }
        authView.originX = self.view.sizeW;
         [self.view addSubview:authView];
    }
    
    [authView.authCodeTextField becomeFirstResponder];
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        authView.originX = (self.view.sizeW - signupView.sizeW)/2;
        signupView.originX = -signinView.sizeW;
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
        if (isShowKeyBoard)
        {
            password.originY -= 100;
        }
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
        nickView.originY = (self.view.sizeH - nickView.sizeH)/2;
        if (isShowKeyBoard)
        {
            nickView.originY -= 100;
        }
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
        [alertView renderView];
    }
}

#pragma mark SIGN DELEGATE

- (void) signRegister
{
    [self prepareSignupView];
}

- (void) signupBackAction
{
    [UIView transitionWithView:signupView duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        signinView.originX = (self.view.sizeW - signupView.sizeW)/2;
        signupView.originX = self.view.sizeW;
    } completion:^(BOOL finished) {
        
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

- (void)authSucceed
{
    [self preparePasswordView];
}


- (void)passwordBack
{
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

- (void)passwordSucceed
{
    [self prepareNickView];
}

- (void)nickNameBack
{
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

- (void)nickNameCompliation
{
    [self parpareAlertView];
//    [self.app loginSucceed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
