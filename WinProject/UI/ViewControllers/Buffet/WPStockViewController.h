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

@interface WPStockViewController : BaseXibViewController<UIScrollViewDelegate,BufferProcudtViewDelegate>

@property(nonatomic,weak) IBOutlet UIView*      switchBarContainer;

@property(nonatomic,assign) id<WPStockViewControllerDelegate> delegate;

@property(nonatomic,weak) IBOutlet UIScrollView*    qScrollViewController;
@property(nonatomic,weak) IBOutlet UIScrollView*    cScrollViewController;

@property(nonatomic,weak) IBOutlet UIImageView* qNoDataImageView;
@property(nonatomic,weak) IBOutlet UIImageView* cNoDataImageView;

@property(nonatomic,weak) IBOutlet UIButton* nextButton;
@property(nonatomic,weak) IBOutlet UIButton* preButton;

@property(nonatomic,assign) NSInteger cProductPage;
@property(nonatomic,assign) NSInteger qProductPage;
@property(nonatomic,assign) BOOL cProductPageLoading;
@property(nonatomic,assign) BOOL qProductPageLoading;

@end


@protocol WPStockViewControllerDelegate <NSObject>

- (void) stockViewClose;

@end