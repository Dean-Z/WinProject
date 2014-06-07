//
//  WPAlipayView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAlipayView.h"
#import "ConversionCell.h"

@implementation WPAlipayView

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
    
    [self prepareData];
    [self.tableview reloadData];
}

- (void)prepareData
{
    _conversionArray = [@[] mutableCopy];
    
    WPConversionInfo* info = [[WPConversionInfo alloc]init];
    info.title = @"提现到支付宝";
    info.desc = @"通过支付宝,金币兑换RMB";
    info.cover = @"icon-alipay.png";
    [_conversionArray addObject:info];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _conversionArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identity = @"Conversion";
    
    ConversionCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConversionCell" owner:self options:nil]lastObject];
    }
    
    cell.conversionInfo = _conversionArray[indexPath.row];
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self prepareAlipayView];
}

#pragma mark About AlipayView

- (void)prepareAlipayView
{
    if (alipayView == nil)
    {
        alipayView = [AlipayView viewFromXib];
        alipayView.originX = self.sizeW;
        alipayView.originY = (self.sizeH - alipayView.sizeH)/2;
        [alipayView renderView];
        [self addSubview:alipayView];
        alipayShowing = YES;
    }

    [UIView animateWithDuration:0.3 animations:^{
        self.tableview.alpha = 0.0f;
        alipayView.originX = 0;
    }];
}

- (IBAction)cancel:(id)sender
{
    if (alipayShowing)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.tableview.alpha = 1.0f;
            alipayView.originX = self.sizeW;
        } completion:^(BOOL finished) {
            [alipayView removeFromSuperview];
            alipayView = nil;
            alipayShowing = NO;
        }];
        return;
    }
    [self.delegate alipayCancel];
}
@end
