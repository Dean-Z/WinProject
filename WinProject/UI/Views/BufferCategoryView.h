//
//  BufferCategoryView.h
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPCDataInfo.h"
#import "MarqueeLabel.h"

@protocol BufferCategoryViewDelegate;
@interface BufferCategoryView : WPBaseView

@property(nonatomic,strong)WPCBaseDateInfo* dataInfo;

@property(nonatomic,weak) IBOutlet UILabel* brandLabel;
@property(nonatomic,weak) IBOutlet UILabel* typeLabel;
@property(nonatomic,weak) IBOutlet UILabel* coinLabel;
@property(nonatomic,weak) IBOutlet UILabel* endTimeLabel;
@property(nonatomic,weak) IBOutlet UIImageView* picImageView;
@property(nonatomic,strong) MarqueeLabel* brandLoopView;

@property(nonatomic,assign) id<BufferCategoryViewDelegate> delegate;

- (void)loopBrand;

@end

@protocol BufferCategoryViewDelegate <NSObject>

- (void) bufferCategoryViewTouched:(WPCBaseDateInfo*)dataInfo;

@end