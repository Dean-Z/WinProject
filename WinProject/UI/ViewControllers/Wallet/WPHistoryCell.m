//
//  WPHistoryCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPHistoryCell.h"
#import "NSDate+TimeAgo.h"

@implementation WPHistoryCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)renderCell
{
    [self.timeLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:12]];
    [self.coinLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:12]];
    
    self.coinLabel.text = [NSString stringWithFormat:@"兑换了%@金币",self.historyInfo.coins];
    NSInteger timeInterval = [self.historyInfo.create_time integerValue];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *timeString = [date dateTimeAgo];
    timeString = [timeString stringByReplacingOccurrencesOfString:@"day ago" withString:@"天前"];
    self.timeLabel.text = timeString;
}

@end
