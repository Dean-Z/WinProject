//
//  WPBillCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBillCell.h"

@implementation WPBillCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

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
//    NSInteger type = [self.historyInfo.type integerValue];
    
//    self.NameType.text = type == 0? @"壁纸收入":@"茶叶蛋";
    
    if ([self.historyInfo.type integerValue] ==0)
    {
        self.coinType.text = @"收入";
        self.NameType.text = @"壁纸收入";
        self.coinType.textColor = [UIColor colorWithHexString:@"009a57"];
    }
    else
    {
        self.coinType.text = @"支出";
        self.NameType.text = @"兑换支出";
        self.coinType.textColor = [UIColor colorWithHexString:@"dd7271"];
    }
    
    self.coinCount.text = [NSString stringWithFormat:@"%@金币",self.historyInfo.coins];
}

@end
