//
//  BufferCProcudtView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPCDataInfo.h"
#import "UIImageView+WebCache.h"
#import "WPProductDetailView.h"

@protocol BufferProcudtViewDelegate;
@interface BufferCProcudtView : WPBaseView<WPProductDetailViewDelegate>

@property(nonatomic,weak) IBOutlet UIView* productBtnContainer;
@property(nonatomic,weak) IBOutlet UIImageView* productImageView;
@property(nonatomic,weak) IBOutlet UILabel* logoLabel;
@property(nonatomic,weak) IBOutlet UILabel* endTimeLabel;
@property(nonatomic,weak) IBOutlet UILabel* remainLabel;
@property(nonatomic,weak) IBOutlet UIButton* touchButton;

@property(nonatomic,weak) WPCBaseDateInfo* dataInfo;
@property(nonatomic,assign) id<BufferProcudtViewDelegate> delegate;
@end

@protocol BufferProcudtViewDelegate <NSObject>

- (void)downloadPicdidFinish;

@end