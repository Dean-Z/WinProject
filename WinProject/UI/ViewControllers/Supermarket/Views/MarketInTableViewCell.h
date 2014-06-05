//
//  MarketInTableViewCell.h
//  WinProject
//
//  Created by Dean on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPMarketInfo.h"

@interface MarketInTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIView* cellbgView;
@property(nonatomic,strong) WPMarketInfo* marketInfo;
@property(nonatomic,weak) IBOutlet UIImageView* coverImage;
@property(nonatomic,weak) IBOutlet UIButton* coinButton;
@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,weak) IBOutlet UILabel* descLabel;
@property(nonatomic,weak) IBOutlet UILabel* timeLabel;

- (void) renderCell;

@end
