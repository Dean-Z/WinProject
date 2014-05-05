//
//  BufferProductView.m
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BufferProductView.h"

@implementation BufferProductView
{
    WPProductButton* productBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void) renderView
{
    [self prepareProductButton];
}

- (void) prepareProductButton
{
    if (productBtn == nil)
    {
        productBtn = [WPProductButton viewFromXib];
        [self.priceBtnContainer addSubview:productBtn];
    }
}

@end
