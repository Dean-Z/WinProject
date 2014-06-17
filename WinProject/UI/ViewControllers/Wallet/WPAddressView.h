//
//  WPAddressView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPAddressViewDelegate;

@interface WPAddressView : WPBaseView

@property(nonatomic,strong) UIView* backgroundView;
@property(nonatomic,weak) IBOutlet UITextField* addressField;
@property(nonatomic,assign) id<WPAddressViewDelegate> delegate;

- (void)showInWindow;

@end

@protocol WPAddressViewDelegate <NSObject>

- (void)addAddressDone;

@end