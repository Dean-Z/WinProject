//
//  LoginViewController.h
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPSigninView.h"
#import "WPSignupView.h"
#import "WPAuthView.h"
#import "WPPasswordView.h"
#import "WPNickName.h"

@interface LoginViewController : BaseXibViewController<WPSigninViewDelegate,WPSignupViewDelegate,WPAuthViewDelegate,WPPasswordViewDelegate,WPNickNameDelegate>

@property(nonatomic,assign) BOOL showKeyBoard;

@end
