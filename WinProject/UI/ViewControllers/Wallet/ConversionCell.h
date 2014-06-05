//
//  ConversionCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPConversionInfo.h"

@interface ConversionCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIView* conversionContainer;

@property (nonatomic,weak) IBOutlet UIImageView* coverImageView;
@property (nonatomic,weak) IBOutlet UILabel* titleLabel;
@property (nonatomic,weak) IBOutlet UILabel* descLabel;

@property (nonatomic,strong) WPConversionInfo* conversionInfo;

- (void)renderCell;

@end
