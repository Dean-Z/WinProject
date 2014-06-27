//
//  BufferProductView.h
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "UIImageView+WebCache.h"
#import "WPProductButton.h"
#import "WPQDateInfo.h"
#import "WPProductDetailView.h"
#import "BufferCProcudtView.h"

@protocol BufferProcudtViewDelegate;
@interface BufferProductView : WPBaseView<WPProductDetailViewDelegate>

@property(nonatomic,weak) IBOutlet UIImageView* productImage;
@property(nonatomic,weak) IBOutlet UILabel*     endTimeLabel;
@property(nonatomic,weak) IBOutlet UILabel*     numberProductLabel;
@property(nonatomic,weak) IBOutlet UIView*      priceBtnContainer;
@property(nonatomic,weak) IBOutlet UIButton* touchButton;
@property(nonatomic,assign) id<BufferProcudtViewDelegate> delegate;
@property(nonatomic,weak) WPQBaseDateInfo* dateInfo;

@end
