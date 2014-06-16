//
//  WPPullView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPPullView.h"
#import "WPPullCell.h"
#import "WPHistoryInfo.h"
#import "NSDate+TimeAgo.h"

@implementation WPPullView

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
    self.hidden = YES;
    self.historyData = [@[] mutableCopy];
    [self.firstCellLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:10]];
    
    isPull = YES;
}

- (IBAction)pullAction:(id)sender
{
    isPull  = !isPull;
    
    if (isPull)
    {
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sizeH = self.pullViewSelected.sizeH;
        } completion:^(BOOL finished) {
            self.pullViewNormal.hidden = YES;
            self.pullViewSelected.hidden = NO;
            self.tableview.hidden = YES;
            self.firstCellLabel.hidden = NO;
        }];
    }
    else
    {
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sizeH = self.pullViewNormal.sizeH;
        } completion:^(BOOL finished) {
            self.pullViewNormal.hidden = NO;
            self.pullViewSelected.hidden = YES;
            self.tableview.hidden = NO;
            self.firstCellLabel.hidden = YES;
        }];
    }
}

- (void)fillDate
{
    NSDictionary* parm = @{@"app":@"user",
                           @"act":@"history",
                           @"perpage":@"10",
                           @"user":self.rakeInfo.userId,
                           @"type":@"2"};
    
    __weak WPPullView* history = self;
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
                        
                        if (history.historyData.count>0)
                        {
                            WPHistoryInfo* info = [history.historyData firstObject];
                            NSInteger timeInterval = [info.create_time integerValue];
                            NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
                            NSString *timeString = [date dateTimeAgo];
                            timeString = [timeString stringByReplacingOccurrencesOfString:@"day ago" withString:@"天前"];
                            self.firstCellLabel.text = [NSString stringWithFormat:@"%@ %@兑换了%@金币",self.rakeInfo.nickname,timeString,info.coins];
                            self.hidden = NO;
                        }
                        else
                        {
                            self.hidden = YES;
                        }
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
    
    static NSString* pullCell = @"pullCell";
    
    WPPullCell* cell = [tableView dequeueReusableCellWithIdentifier:pullCell];
    
    if (cell == nil)
    {
        cell = [WPPullCell viewFromXib];
    }
    
    cell.userName = self.rakeInfo.nickname;
    cell.historyInfo = self.historyData[indexPath.row];
    [cell renderCell];
    
    return cell;
}

@end
