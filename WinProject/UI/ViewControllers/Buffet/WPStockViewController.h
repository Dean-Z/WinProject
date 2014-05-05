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

@protocol WPStockViewControllerDelegate;

@interface WPStockViewController : BaseXibViewController

@property(nonatomic,weak) IBOutlet UIView*      switchBarContainer;

@property(nonatomic,assign) id<WPStockViewControllerDelegate> delegate;

@property(nonatomic,weak) IBOutlet UIScrollView*    qScrollViewController;
@property(nonatomic,weak) IBOutlet UIScrollView*    cScrollViewController;

@end


@protocol WPStockViewControllerDelegate <NSObject>

- (void) stockViewClose;

@end