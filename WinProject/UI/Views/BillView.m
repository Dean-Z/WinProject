//
//  BillView.m
//  WinProject
//
//  Created by Dean-Z on 14-4-30.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BillView.h"

@implementation BillView

- (void)renderView
{
    [super renderView];
    
    [self prepareData];
}

- (void)prepareData
{
    NSDictionary* parm = @{@"app":@"cash",@"act":@"history",@"page":@"1"};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
