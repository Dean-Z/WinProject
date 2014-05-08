//
//  RakeView.m
//  WinProject
//
//  Created by Dean-Z on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "RakeView.h"

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
        
        [switchBar renderBarWithLeftContenct:@"全国排名" RightContent:@"好友排名"
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
        pullView.originX = 30;
        pullView.originY = 140;
        [self addSubview:pullView];
    }
}

-(void)switchBarChangeValue
{
    DLog(@"dasdas");
}

@end
