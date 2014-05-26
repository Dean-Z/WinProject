//
//  WPProductDetailView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-26.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPProductInfo.h"

@interface WPProductDetailView : WPBaseView

@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,weak) IBOutlet UILabel* descLabel;

@property(nonatomic,strong) WPProductInfo* productInfo;

@property(nonatomic,strong) UIView* backgroundView;

@end
