//
//  WPRegisterAlert.h
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPRegisterAlertDelegate;

@interface WPRegisterAlert : WPBaseView

@property(nonatomic,assign) id<WPRegisterAlertDelegate> delegate;

@end


@protocol WPRegisterAlertDelegate <NSObject>

- (void) registerSucceed;

@end