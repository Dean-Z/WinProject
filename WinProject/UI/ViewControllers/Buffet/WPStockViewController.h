//
//  WPStockViewController.h
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPSwitchBar.h"
#import "BufferProductView.h"
#import "BufferCProcudtView.h"
#import "WPQDateInfo.h"
#import "WPCDataInfo.h"

@protocol WPStockViewControllerDelegate;

@interface WPStockViewController : BaseXibViewController<UIScrollViewDelegate>

@property(nonatomic,weak) IBOutlet UIView*      switchBarContainer;

@property(nonatomic,assign) id<WPStockViewControllerDelegate> delegate;

@property(nonatomic,weak) IBOutlet UIScrollView*    qScrollViewController;
@property(nonatomic,weak) IBOutlet UIScrollView*    cScrollViewController;

@property(nonatomic,weak) IBOutlet UIImageView* qNoDataImageView;
@property(nonatomic,weak) IBOutlet UIImageView* cNoDataImageView;

@property(nonatomic,weak) IBOutlet UIButton* nextButton;
@property(nonatomic,weak) IBOutlet UIButton* preButton;

@end


@protocol WPStockViewControllerDelegate <NSObject>

- (void) stockViewClose;

@end