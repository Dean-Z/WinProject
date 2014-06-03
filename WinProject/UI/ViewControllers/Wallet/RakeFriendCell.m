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
    [self.nameLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
    [self.nameLabel setTextColor:[self colorWithRake:1]];
    
    [self.rakeLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
    [self.rakeLabel setTextColor:[self colorWithRake:1]];
    
    [self.coinLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:[self sizeWithRake:1]]];
    [self.coinLabel setTextColor:[self colorWithRake:1]];
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

- (UIColor*)selfColor
{
    return [UIColor colorWithHexString:@"dd6e69"];
}

@end
