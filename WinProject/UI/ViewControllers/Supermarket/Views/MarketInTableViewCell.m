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
    
    self.coverImage.image = [UIImage imageNamed:self.marketInfo.cover];
    [self.coinButton setTitle:[NSString stringWithFormat:@"奖励%@金币",self.marketInfo.coins] forState:UIControlStateNormal];
    self.titleLabel.text = self.marketInfo.title;
    self.descLabel.text = self.marketInfo.desc;
    self.timeLabel.text = self.marketInfo.timeLimit;
}

@end
