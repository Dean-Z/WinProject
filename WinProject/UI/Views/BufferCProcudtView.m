//
//  BufferCProcudtView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BufferCProcudtView.h"
#import "WPCProductButton.h"

@implementation BufferCProcudtView
{
    WPCProductButton* productBtn;
}

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
    [self prepareProductBtn];
    [self.productImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url]];
}

- (void) prepareProductBtn
{
    if(productBtn == nil)
    {
        productBtn = [WPCProductButton viewFromXib];
        [productBtn renderView];
        [self.productBtnContainer addSubview:productBtn];
    }
}

@end
