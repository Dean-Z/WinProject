//
//  WPAlertView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPAlertView : WPBaseView

@property(nonatomic,weak) IBOutlet UILabel* messageLabel;

-(void)showWithMessage:(NSString*)message;

@end
