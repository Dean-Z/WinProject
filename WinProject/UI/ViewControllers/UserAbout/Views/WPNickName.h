//
//  WPNickName.h
//  WinProject
//
//  Created by Dean-Z on 14-5-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPNickNameDelegate;

@interface WPNickName : WPBaseView

@property(nonatomic,weak) IBOutlet UITextField* nickTextField;
@property(nonatomic,weak) IBOutlet UILabel* errorLabel;

@property(nonatomic,assign) id<WPNickNameDelegate> delegate;

@end

@protocol WPNickNameDelegate <NSObject>

- (void) nickNameBack;

- (void) nickNameCompliation;

@end