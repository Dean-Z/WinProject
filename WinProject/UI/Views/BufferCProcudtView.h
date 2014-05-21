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

@interface BufferCProcudtView : WPBaseView

@property(nonatomic,weak) IBOutlet UIView* productBtnContainer;
@property(nonatomic,weak) IBOutlet UIImageView* productImageView;

@property(nonatomic,weak) WPCBaseDateInfo* dataInfo;

@end
