//
//  WPBillCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHistoryInfo.h"

@interface WPBillCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel* NameType;
@property(nonatomic,weak) IBOutlet UILabel* coinType;
@property(nonatomic,weak) IBOutlet UILabel* coinCount;

@property(nonatomic,strong) WPHistoryInfo* historyInfo;

- (void)renderCell;

@end
