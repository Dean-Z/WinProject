//
//  WPScollImageViewController.h
//  WinProject
//
//  Created by Dean-Z on 14-6-27.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPCDataInfo.h"

@interface WPScollImageViewController : BaseXibViewController<UIScrollViewDelegate>

@property(nonatomic,weak) IBOutlet UIScrollView     *mainScrollView;
@property(nonatomic,weak) IBOutlet UIImageView      *mainImageView;
@property(nonatomic,strong) WPCBaseDateInfo* dataInfo;

@end
