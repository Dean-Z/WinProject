//
//  WPSigninView.h
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "TTTAttributedLabel.h"
#import "TSValidatedTextField.h"

@protocol WPSigninViewDelegate;
@interface WPSigninView : WPBaseView<TTTAttributedLabelDelegate>

@property(nonatomic,weak) IBOutlet TTTAttributedLabel* forgotPasswordLabel;
@property(nonatomic,assign) id<WPSigninViewDelegate> delegate;
@property(nonatomic,weak) IBOutlet TSValidatedTextField* phoneTextField;
@property(nonatomic,weak) IBOutlet TSValidatedTextField* passwordTextField;

@end

@protocol WPSigninViewDelegate <NSObject>

-(void)signinSucceed;
-(void)signRegister;
-(void)findPassword;

@end