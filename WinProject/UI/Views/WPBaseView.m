//
//  WPBaseView.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@implementation WPBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) renderView
{
    self.app = [AppDelegate shareAppDelegate];
}

- (UIView*)inputAccessoryBar
{
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(270, 5, 50, 20)];
    [button addTarget:self action:@selector(dismissKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [topView addSubview:button];
    
    return topView;
}

- (void)dismissKeyBoard
{}

@end
