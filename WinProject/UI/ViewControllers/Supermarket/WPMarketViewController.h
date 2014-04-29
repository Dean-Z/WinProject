//
//  WPMarketViewController.h
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"

@interface WPMarketViewController : BaseXibViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView* productTabelView;
@property(nonatomic,weak) IBOutlet UIView*      switchBarContainer;

@end
