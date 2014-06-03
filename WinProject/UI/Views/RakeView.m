//
//  RakeView.m
//  WinProject
//
//  Created by Dean-Z on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "RakeView.h"
#import "RakeFriendCell.h"

@implementation RakeView

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
    [self prepareSwithBar];
    [self preparePullView];
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
       pullView.hidden = NO;
    }
    else
    {
        pullView.hidden = YES;
    }
}


#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
        
        [cell renderView];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 27.0f;
}

@end
