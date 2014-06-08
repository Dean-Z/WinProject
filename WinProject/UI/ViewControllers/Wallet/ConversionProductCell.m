//
//  ConversionProductCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "ConversionProductCell.h"

@implementation ConversionProductCell

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
}

- (void)renderCell
{
    self.cellContainer.layer.cornerRadius = 3.0f;
    [self.logoImageView setImageWithURL:[NSURL URLWithString:self.conversionInfo.logo] placeholderImage:[UIImage imageNamed:@"test-01.png"]];
    self.titleLabel.text = self.conversionInfo.title;
    self.descLabel.text = self.conversionInfo.desc;
    self.coinLabel.text = [NSString stringWithFormat:@"%@金币",self.conversionInfo.coins];
}

@end