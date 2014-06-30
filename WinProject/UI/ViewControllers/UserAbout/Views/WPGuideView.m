//
//  WPGuideView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPGuideView.h"

@implementation WPGuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    [self.scrollview setContentSize:CGSizeMake(320*3+3, 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 640.0f)
    {
        [self skip:nil];
    }
}


- (IBAction)skip:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.originX = - 320.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
