//
//  WPPullCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPHistoryInfo.h"

@interface WPPullCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UILabel* contentlabel;

@property(nonatomic,strong) WPHistoryInfo* historyInfo;
@property(nonatomic,strong) NSString* userName;

-(void)renderCell;

@end
