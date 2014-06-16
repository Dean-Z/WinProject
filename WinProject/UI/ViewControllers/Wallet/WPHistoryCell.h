//
//  WPHistoryCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHistoryInfo.h"

@interface WPHistoryCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel* coinLabel;
@property(nonatomic,weak) IBOutlet UILabel* timeLabel;

@property(nonatomic,strong) WPHistoryInfo* historyInfo;

- (void)renderCell;

@end
