//
//  WPPasswordView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPPasswordViewDelegate;

@interface WPPasswordView : WPBaseView<UITextFieldDelegate>

@property(nonatomic,weak) IBOutlet UITextField* password_1;
@property(nonatomic,weak) IBOutlet UITextField* password_2;

@property(nonatomic,weak) IBOutlet UILabel*     errorLabel_1;
@property(nonatomic,weak) IBOutlet UILabel*     errorLabel_2;

@property(nonatomic,assign) id<WPPasswordViewDelegate> delegate;

@end

@protocol WPPasswordViewDelegate <NSObject>

- (void) passwordBack;

- (void) passwordSucceed;

@end