//
//  MarketInTableViewCell.m
//  WinProject
//
//  Created by Dean on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "MarketInTableViewCell.h"

@implementation MarketInTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void) renderCell
{
    self.cellbgView.layer.masksToBounds = YES;
    self.cellbgView.layer.cornerRadius = 3.0f;
    
    if (self.marketInfo.type == Market_Question_Type)
    {
       [self.coverImage setImageWithURL:[NSURL URLWithString:self.marketInfo.cover] placeholderImage:[UIImage imageNamed:@"icon-ask.png"]];
    }
    else
    {
        self.coverImage.image = [UIImage imageNamed:self.marketInfo.cover];
    }
    
    [self.coinButton setTitle:[NSString stringWithFormat:@"奖励%@金币",self.marketInfo.coins] forState:UIControlStateNormal];
    self.titleLabel.text = self.marketInfo.title;
    self.descLabel.text = self.marketInfo.desc;
    if ([self.marketInfo.end_time integerValue]>0)
    {
        NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[self.marketInfo.end_time integerValue]];
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        self.timeLabel.text = [NSString stringWithFormat:@"有效期至:%@",[formatter stringFromDate:endDate]];
    }
    else
    {
        self.timeLabel.text = self.marketInfo.timeLimit;
    }
}

@end
