//
//  AlipayView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface AlipayView : WPBaseView
{
    NSInteger _currentCoins;
}
@property(nonatomic,weak) IBOutlet UIView* passwordContainer;
@property(nonatomic,weak) IBOutlet UIView* coinsContainer;
@property(nonatomic,weak) IBOutlet UIView* alertContainer;
@property(nonatomic,weak) IBOutlet UITextField* passwordField;
@property(nonatomic,weak) IBOutlet UIImageView* passwordBgImageView;

@property(nonatomic,weak) IBOutlet UIButton* coin1;
@property(nonatomic,weak) IBOutlet UIButton* coin10;
@property(nonatomic,weak) IBOutlet UIButton* coin20;
@property(nonatomic,weak) IBOutlet UIButton* coin50;

@property(nonatomic,weak) IBOutlet UILabel* needCoins;
@property(nonatomic,weak) IBOutlet UILabel* hasCoins;

@end
