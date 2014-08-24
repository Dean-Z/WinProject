//
//  WPGoodsViewController.h
//  WinProject
//
//  Created by Dean-Z on 14-8-22.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPConversionInfo.h"
#import "UIImageView+WebCache.h"

@interface WPGoodsViewController : BaseXibViewController

@property (nonatomic, weak) IBOutlet UIScrollView *scrollview;
@property (nonatomic, weak) IBOutlet UILabel *titlelabe;
@property (nonatomic,strong) WPConversionInfo* conversionInfo;

@end
