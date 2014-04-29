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
}

@end
