//
//  WPHistoryView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-16.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPHistoryView.h"
#import "WPHistoryInfo.h"
#import "WPHistoryCell.h"
#import "FTAnimationManager.h"

@implementation WPHistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    self.historyData =  [@[] mutableCopy];
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    [self.backgroundView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@的兑换记录",self.userName];
    [self prepareData];
}

- (void)prepareData
{
    NSDictionary* parm = @{@"app":@"user",
                           @"act":@"history",
                           @"perpage":@"10",
                           @"user":self.userId,
                           @"type":@"2"};
    
    __weak WPHistoryView* history = self;
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
                            [history.historyData addObject:info];
                            info = nil;
                        }
                        [history.tableview reloadData];
                    }
                }
            }
        }
        if (self.historyData.count == 0)
        {
            self.noDataLabel.hidden = NO;
        }
    }];
}

- (void)showInWindow
{
    [self.app.window addSubview:self.backgroundView];
    
    self.center = self.app.window.center;
    self.hidden = YES;
    [self.app.window addSubview:self];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (void)dismiss
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    [self performSelector:@selector(removerSuberViews) withObject:nil afterDelay:0.5];
}

- (void) removerSuberViews
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
    
    [self.historyData removeAllObjects];
    self.historyData = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* historyCell = @"historyCell";
    
    WPHistoryCell* cell = [tableView dequeueReusableCellWithIdentifier:historyCell];
    
    if (cell == nil)
    {
        cell = [WPHistoryCell viewFromXib];
    }
    
    cell.historyInfo = self.historyData[indexPath.row];
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 24.0f;
}

@end
