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
#import "WPHistoryView.h"

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
        pullView.shouldHidden = NO;
        [pullView showView];
        self.friendTableView.hidden = NO;
        self.countryTableView.hidden = YES;
    }
    else
    {
        pullView.shouldHidden = YES;
        pullView.hidden = YES;
        self.friendTableView.hidden = YES;
        self.countryTableView.hidden = NO;
    }
}


- (void)prepareData
{
//    if (self.hasLoadData)
//    {
//        return;
//    }
//    self.hasLoadData = YES;
    __weak RakeView* rake = self;
    
    NSMutableDictionary* parm = [@{@"app":@"rank",@"act":@"index"} mutableCopy];
    
    // 全国用户
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            id date = [NSObject toJSONValue:resp];
            
            if ([date isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* result = [date objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]])
                {
                    NSArray* resultData = [date objectForKey:@"result"][@"data"];
                    
                    if (resultData > 0)
                    {
                        for (NSDictionary* dict in resultData)
                        {
                            WPRakeInfo* info = [[WPRakeInfo alloc] init];
                            info.data = dict;
                            [_countryRake addObject:info];
                        }
                        [rake.countryTableView reloadData];
                    }
                    else
                    {
                        DLog(@"NO DATA");
                    }
                    
                    rake.resultDict = [date objectForKey:@"result"];
                    [self resetRakes];
                }
            }
            else
            {
                self.positionLabel.text = @"--";
                self.rateLabel.text = @"--";
                self.gapLabel.text = @"--";
            }
        }
    }];
    
    parm = [@{@"app":@"rank",@"act":@"user"} mutableCopy];
    
    [self contents:^(NSString *result) {
        // 好友
        [parm setObject:result forKey:@"address"];
        
        [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
            if (resp)
            {
                id date = [NSObject toJSONValue:resp];
                
                if ([date isKindOfClass:[NSDictionary class]])
                {
                    NSArray* result = [date objectForKey:@"result"][@"data"];
                    if (result.count > 0)
                    {
                        for (NSDictionary* dict in result)
                        {
                            WPRakeInfo* info = [[WPRakeInfo alloc] init];
                            info.data = dict;
                            [_friendsRake addObject:info];
                        }
                        
                        [rake.friendTableView reloadData];
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
    }];
}

- (void)resetRakes
{
    if ([self.resultDict isKindOfClass:[NSDictionary class]])
    {
        NSString* postionString = [self.resultDict objectForKey:@"position"];
        self.positionLabel.text = [NSString stringWithFormat:@"%@",postionString];
        NSString *str = @"%";
        self.rateLabel.text = [NSString stringWithFormat:@"%@%@",self.resultDict[@"rate"],str];
        self.gapLabel.text = [NSString stringWithFormat:@"%@",self.resultDict[@"gap"]];
    }
}

- (void) contents:(void (^)(NSString *))complate
{
    [[CCGetContactPerson shareCCGetContactPerson]
     personDataRefresh:NO
     Complate:^(NSMutableArray *records)
    {
        NSString* phones = @"";
        for (NSInteger i=0; i<records.count; i++)
        {
            ABRecordRef ref = (__bridge ABRecordRef)(records[i]);
            NSDictionary* dict = [[CCGetContactPerson shareCCGetContactPerson]recordPhone:ref];
            
            for (NSString* key in [dict allKeys])
            {
                NSString* number = [dict objectForKey:key];
                number = [self dealPhoneNumber:number];
                phones = [phones stringByAppendingString:number];
                phones = [phones stringByAppendingString:@","];
            }
        }
        if (phones.length>1)
        {
            phones = [phones substringToIndex:phones.length-1];
        }
        complate(phones);
    }];
}

- (NSString*)dealPhoneNumber:(NSString*)number
{
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    number = [number stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    return number;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPRakeInfo* info;
    if (tableView == self.friendTableView)
    {
        info = _friendsRake[indexPath.row];
    }
    else
    {
        info = _countryRake[indexPath.row];
    }
    
    WPHistoryView* history = [WPHistoryView viewFromXib];
    history.userId = info.userId;
    history.userName = info.nickname;
    [history renderView];
    [history showInWindow];
}

@end
