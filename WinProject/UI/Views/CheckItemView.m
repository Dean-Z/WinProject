//
//  CheckItemView.m
//  WinProject
//
//  Created by Dean on 14-4-24.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "CheckItemView.h"

@implementation CheckItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)onCheckItemCilcked:(id)sender
{
    isClicked = !isClicked;
    
    [self.selectedlImage setHidden:!isClicked];
    
    if ([self.delegate respondsToSelector:@selector(CheckItemViewisClicked:)])
    {
        [self.delegate CheckItemViewisClicked:isClicked];
    }
}

@end
