//
//  ConversionProductCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPConversionInfo.h"
#import "UIImageView+WebCache.h"

@interface ConversionProductCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIView* cellContainer;
@property(nonatomic,weak) IBOutlet UIImageView* logoImageView;
@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,weak) IBOutlet UILabel* descLabel;
@property(nonatomic,weak) IBOutlet UILabel* coinLabel;

@property(nonatomic,strong) WPConversionInfo* conversionInfo;

- (void)renderCell;

@end
