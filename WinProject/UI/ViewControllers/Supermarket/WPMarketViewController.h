//
//  WPMarketViewController.h
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPInformationView.h"

@interface WPMarketViewController : BaseXibViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView* productTabelView;
@property(nonatomic,weak) IBOutlet UIView*      switchBarContainer;
@property(nonatomic,weak) IBOutlet UIView*      informationViewContainer;

@property(nonatomic,weak) IBOutlet UIButton* refreshButton;
@property(nonatomic,weak) IBOutlet UIButton* cancelButton;

@end
