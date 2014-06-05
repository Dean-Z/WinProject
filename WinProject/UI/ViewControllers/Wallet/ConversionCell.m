//
//  ConversionCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "ConversionCell.h"

@implementation ConversionCell

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
    self.conversionContainer.layer.cornerRadius = 3.0f;
    self.conversionContainer.layer.masksToBounds = YES;
    
    self.coverImageView.image = [UIImage imageNamed:self.conversionInfo.cover];
    self.titleLabel.text = self.conversionInfo.title;
    self.descLabel.text = self.conversionInfo.desc;
}

@end
