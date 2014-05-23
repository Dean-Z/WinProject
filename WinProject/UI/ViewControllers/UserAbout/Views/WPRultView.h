//
//  WPRultView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPRultView : WPBaseView

@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,weak) IBOutlet UIScrollView* containScrollView;
@property(nonatomic,weak) IBOutlet UILabel* messageLabel;
@property(nonatomic,weak) IBOutlet UIImageView* scrollBarItem;

-(void)showWithMessage:(NSString*)message title:(NSString*)title;

@end
