//
//  WPPullCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPPullCell.h"
#import "NSDate+TimeAgo.h"

@implementation WPPullCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) renderCell
{
    [self.contentlabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:12]];
    
//    NSInteger timeInterval = [self.historyInfo.create_time integerValue];
//    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSString *timeString = [date dateTimeAgo];
//    timeString = [timeString stringByReplacingOccurrencesOfString:@"day ago" withString:@"天前"];
    
    if ([NSString isNilOrEmpty:self.historyInfo.goods])
    {
       self.contentlabel.text = [NSString stringWithFormat:@"%@提现了%@金币",self.userName,self.historyInfo.coins];
    }
    else
    {
        self.contentlabel.text = [NSString stringWithFormat:@"%@兑换了%@",self.userName,self.historyInfo.goods];
    }
}

@end
