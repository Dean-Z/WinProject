//
//  RakeView.m
//  WinProject
//
//  Created by Dean-Z on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "RakeView.h"
#import "RakeFriendCell.h"
#import "WPRakeInfo.h"

@implementation RakeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)renderView
{
    [self prepareSwithBar];
    [self preparePullView];
    
    _countryRake = [@[] mutableCopy];
    _friendsRake = [@[] mutableCopy];
    
}

- (void)prepareSwithBar
{
    if (switchBar == nil)
    {
        switchBar = [WPSwitchBar viewFromXib];
        
        [switchBar renderBarWithLeftContenct:@"好友排名" RightContent:@"全国排名"
                                      action:@selector(switchBarChangeValue) target:self];
        [self.switchBarContainer addSubview:switchBar];
    }
}

- (void) preparePullView
{
    if (pullView == nil)
    {
        pullView = [WPPullView viewFromXib];
        [pullView renderView];
        pullView.originX = self.sizeW/2 - pullView.sizeW/2;
        pullView.originY = 145;
        [self addSubview:pullView];
    }
}

-(void)switchBarChangeValue
{
    if (switchBar.selectAtIndex == 0)
    {
        if (!noData)
        {
            pullView.hidden = NO;
        }
        self.friendTableView.hidden = NO;
        self.countryTableView.hidden = YES;
    }
    else
    {
        pullView.hidden = YES;
        self.friendTableView.hidden = YES;
        self.countryTableView.hidden = NO;
    }
}


- (void)prepareData
{
    if (self.hasLoadData)
    {
        return;
    }
    self.hasLoadData = YES;
    
    NSMutableDictionary* parm = [@{@"app":@"rank",@"act":@"index"} mutableCopy];
    
    // 全国用户
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            id date = [NSObject toJSONValue:resp];
            
            if ([date isKindOfClass:[NSDictionary class]])
            {
                NSArray* result = [date objectForKey:@"result"];
                
                if (result > 0)
                {
                    for (NSDictionary* dict in result)
                    {
                        WPRakeInfo* info = [[WPRakeInfo alloc] init];
                        info.data = dict;
                        [_countryRake addObject:info];
                    }
                    [self.countryTableView reloadData];
                }
                else
                {
                    DLog(@"NO DATA");
                }
            }
        }
    }];
    
    parm = [@{@"app":@"rank",@"act":@"user",@"address":@"address"} mutableCopy];
    
    // 好友
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            id date = [NSObject toJSONValue:resp];
            
            if ([date isKindOfClass:[NSDictionary class]])
            {
                NSArray* result = [date objectForKey:@"result"];
                if (result.count > 0)
                {
                    for (NSDictionary* dict in result)
                    {
                        WPRakeInfo* info = [[WPRakeInfo alloc] init];
                        info.data = dict;
                        [_friendsRake addObject:info];
                    }
                    
                    [self.friendTableView reloadData];
                    pullView.rakeInfo = [_friendsRake firstObject];
                    [pullView fillDate];
                }
                else
                {
                    DLog(@"NO DATA");
                    noData = YES;
                    pullView.hidden = YES;
                }
            }
        }
    }];
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.friendTableView)
    {
        return [_friendsRake count];
    }
    else
    {
        return [_countryRake count];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.friendTableView)
    {
        static NSString* friendRake = @"friendRake";
        
        RakeFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:friendRake];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RakeFriendCell" owner:self options:nil]lastObject];
        }
        cell.rakeIndex = indexPath.row + 1;
        cell.rakeInfo = _friendsRake[indexPath.row];
        [cell renderView];
        
        return cell;
    }
    else
    {
        static NSString* countryRake = @"countryRake";
        
        RakeFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:countryRake];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RakeFriendCell" owner:self options:nil]lastObject];
        }
        
        cell.rakeIndex = indexPath.row + 1;
        cell.rakeInfo = _countryRake[indexPath.row];
        
        [cell renderView];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 27.0f;
}

@end
