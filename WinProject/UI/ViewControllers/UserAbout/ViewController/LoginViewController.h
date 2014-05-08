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

@interface LoginViewController : BaseXibViewController<WPSigninViewDelegate,WPSignupViewDelegate,WPAuthViewDelegate>


@end
