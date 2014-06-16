//
//  WPHistoryView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPHistoryView : WPBaseView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView* tableview;
@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@property(nonatomic,strong) NSString* userId;
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSMutableArray* historyData;
@property(nonatomic,weak) IBOutlet UILabel* noDataLabel;

@property(nonatomic,strong) UIView* backgroundView;

- (void)showInWindow;

@end
