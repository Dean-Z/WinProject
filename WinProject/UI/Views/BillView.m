//
//  BillView.m
//  WinProject
//
//  Created by Dean-Z on 14-4-30.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BillView.h"
#import "WPHistoryInfo.h"
#import "WPBillCell.h"

@implementation BillView

- (void)renderView
{
    [super renderView];
    
    self.historyData = [@[] mutableCopy];
    [self prepareData];
}

- (void)prepareData
{
    NSDictionary* parm = @{@"app":@"user",
                           @"act":@"history",
                           @"perpage":@"10",
                           @"user":@"",
                           @"type":@"0"};
    
    __weak BillView* bill = self;
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [self.historyData removeAllObjects];
            id data = [NSObject toJSONValue:resp];
            if ([data isKindOfClass:[NSDictionary class]])
            {
                id result = data[@"result"];
                if ([result isKindOfClass:[NSDictionary class]])
                {
                    id resultData = result[@"data"];
                    if ([resultData isKindOfClass:[NSArray class]])
                    {
                        for (NSDictionary* dictData in resultData)
                        {
                            WPHistoryInfo* info = [[WPHistoryInfo alloc]init];
                            info.data = dictData;
                            [bill.historyData addObject:info];
                            info = nil;
                        }
                        [bill.tableview reloadData];
                    }
                }
            }
        }
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* billCell = @"billCell";
    
    WPBillCell *cell = [tableView dequeueReusableCellWithIdentifier:billCell];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WPBillCell" owner:self options:nil]lastObject];
    }
    
    cell.historyInfo = self.historyData[indexPath.row];
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end
