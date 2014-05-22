//
//  WPBuffetViewController.h
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPStockViewController.h"

@interface WPBuffetViewController : BaseXibViewController<WPStockViewControllerDelegate>

@property(nonatomic,weak) IBOutlet UIScrollView* productContainerView;

@end
