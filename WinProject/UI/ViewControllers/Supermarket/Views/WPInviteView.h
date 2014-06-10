//
//  WPInviteView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPInviteViewDelegate;
@interface WPInviteView : WPBaseView

@property (nonatomic,strong) UIView* backgroundView;
@property (nonatomic,weak) IBOutlet UITextField* phoneTextField;
@property (nonatomic,assign) id<WPInviteViewDelegate> delegate;

- (void)showInWindow;
- (void)dismiss;

@end

@protocol WPInviteViewDelegate <NSObject>

- (void)inviteSucceed;

@end