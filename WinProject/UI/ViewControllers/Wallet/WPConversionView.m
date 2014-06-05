//
//  WPConversionView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPConversionView.h"
#import "WPConversionInfo.h"
#import "ConversionCell.h"

@implementation WPConversionView
{
    NSMutableArray* _conversionArray;
}
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
    
    [self prepareData];
    [self.tableview reloadData];
}

- (void)prepareData
{
    _conversionArray = [@[] mutableCopy];
    
    WPConversionInfo* info = [[WPConversionInfo alloc]init];
    info.title = @"提现充值";
    info.desc = @"毛爷爷、Q币、话费通通在这里";
    info.cover = @"icon-con-m.png";
    [_conversionArray addObject:info];
    
    WPConversionInfo* info2 = [[WPConversionInfo alloc]init];
    info2.title = @"疯狂商城";
    info2.desc = @"精彩商品换不停";
    info2.cover = @"icon-con-w.png";
    [_conversionArray addObject:info2];
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

- (IBAction)cancel:(id)sender
{
    [self.delegate conversionCancel];
}

@end
