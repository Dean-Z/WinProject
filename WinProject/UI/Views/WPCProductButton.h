//
//  WPCProductButton.h
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPCProductButton : WPBaseView

@property(nonatomic,assign) NSInteger coins;
@property(nonatomic,weak) IBOutlet UILabel *coinsLabel;

@end
