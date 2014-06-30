//
//  RakeFirendCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-3.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "RakeFriendCell.h"

@implementation RakeFriendCell

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

- (void)renderView
{
    [self.nameLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:self.rakeInfo.rake]]];
    [self.nameLabel setTextColor:[self colorWithRake:self.rakeInfo.rake]];
    
    if (self.rakeInfo.rake<4 && self.rakeInfo.rake != -1)
    {
        self.rakeTopImageView.image = [self topImageWithRake:self.rakeInfo.rake];
        self.rakeTopImageView.hidden = NO;
        self.rakeLabel.hidden = YES;
    }
    else
    {
        self.rakeTopImageView.hidden = YES;
        [self.rakeLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:self.rakeInfo.rake]]];
        [self.rakeLabel setTextColor:[self colorWithRake:self.rakeInfo.rake]];
    }
    
    [self.coinLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:self.rakeInfo.rake]]];
    [self.coinLabel setTextColor:[self colorWithRake:self.rakeInfo.rake]];
    
    if (self.rakeInfo.rake != -1)
    {
        self.nameLabel.text = self.rakeInfo.nickname;
        self.coinLabel.text = [NSString stringWithFormat:@"%@金币",self.rakeInfo.coins];
        self.rakeLabel.text = [NSString stringWithFormat:@"%d",self.rakeInfo.rake];
    }
    else
    {
        [self.rakeLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
        [self.nameLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
        [self.coinLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
    }

    AppDelegate* app = [AppDelegate shareAppDelegate];
    if ([self.rakeInfo.userId isEqualToString:app.userInfo.userId])
    {
        self.coinLabel.textColor = [UIColor colorWithHexString:@"db6363"];
        self.rakeLabel.textColor = [UIColor colorWithHexString:@"db6363"];
        self.nameLabel.textColor = [UIColor colorWithHexString:@"db6363"];
    }
}

- (UIColor*)colorWithRake:(NSInteger)rake
{
    if (rake == 1)
    {
       return [UIColor colorWithHexString:@"ed9500"];
    }
    else if (rake == 2)
    {
        return [UIColor colorWithHexString:@"7e7e7e"];
    }
    else if (rake == 3)
    {
        return [UIColor colorWithHexString:@"aa868b"];
    }
    else
    {
        return [UIColor colorWithHexString:@"808080"];
    }
}

- (CGFloat)sizeWithRake:(NSInteger)rake
{
    if (rake == 1)
    {
        return 13;
    }
    else if (rake == 2)
    {
        return 12;
    }
    else if (rake == 3)
    {
        return 11;
    }
    else
    {
        return 10;
    }
}

- (UIImage*)topImageWithRake:(NSInteger)rake
{
    if (rake == 1)
    {
        return [UIImage imageNamed:@"top1.png"];
    }
    else if (rake == 2)
    {
        return [UIImage imageNamed:@"top2.png"];
    }
    else if (rake == 3)
    {
        return [UIImage imageNamed:@"top3.png"];
    }
    return nil;
}

- (UIColor*)selfColor
{
    return [UIColor colorWithHexString:@"dd6e69"];
}

@end
