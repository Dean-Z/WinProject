//
//  WPCProductButton.m
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPCProductButton.h"

@implementation WPCProductButton

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
    
    [self.coinsLabel setText:[NSString stringWithFormat:@"下载可赚%d金币",self.coins]];
}

@end
