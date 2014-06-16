//
//  BillView.h
//  WinProject
//
//  Created by Dean-Z on 14-4-30.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPHistoryInfo.h"

@interface BillView : WPBaseView <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* _billDataArray;
}

@property(nonatomic,weak) IBOutlet UITableView* tableview;
@property(nonatomic,strong) NSMutableArray* historyData;

- (void)prepareData;

@end
