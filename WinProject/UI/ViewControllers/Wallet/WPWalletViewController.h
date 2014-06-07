//
//  WPWalletViewController.h
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "RakeView.h"
#import "BillView.h"
#import "WPConversionView.h"
#import "WPAlipayView.h"

@interface WPWalletViewController : BaseXibViewController<UIScrollViewDelegate,WPConversionViewDelegate,WPAlipayViewDelegate>

@property(nonatomic,weak) IBOutlet UIButton* exchangeButton;
@property(nonatomic,weak) IBOutlet UIButton* shareButton;
@property(nonatomic,weak) IBOutlet UIScrollView* mainScrollView;
@property(nonatomic,weak) IBOutlet UIImageView* bgImageView;

@property(nonatomic,weak) IBOutlet UILabel*  coinLabel;
@property(nonatomic,weak) IBOutlet UILabel*  yuanLabel;
@property(nonatomic,weak) IBOutlet UILabel*  titleLabel;

@end
