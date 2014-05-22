//
//  BufferCategoryView.h
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPCDataInfo.h"

@interface BufferCategoryView : WPBaseView

@property(nonatomic,strong)WPCBaseDateInfo* dataInfo;

@property(nonatomic,weak) IBOutlet UILabel* brandLabel;
@property(nonatomic,weak) IBOutlet UILabel* typeLabel;
@property(nonatomic,weak) IBOutlet UILabel* coinLabel;
@property(nonatomic,weak) IBOutlet UILabel* endTimeLabel;
@property(nonatomic,weak) IBOutlet UIImageView* picImageView;

@end
