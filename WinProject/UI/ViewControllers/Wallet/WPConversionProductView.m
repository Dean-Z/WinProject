//
//  WPConversionProductView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPConversionProductView.h"
#import "ConversionProductCell.h"

@implementation WPConversionProductView
{
    NSMutableArray* _coinversionArray;
}

- (void)renderView
{
    self.page = 1;
    _coinversionArray = [@[] mutableCopy];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self prepareDateWithPage:self.page];
}

- (void)prepareDateWithPage:(NSInteger)page
{
    if (self.pageLoading)
    {
        return;
    }
    self.pageLoading = YES;
    NSDictionary* parm = @{@"app":@"exchange",
                           @"act":@"list",
                           @"page":[NSString stringWithFormat:@"%d",page]};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        
        [SVProgressHUD dismiss];
        self.pageLoading = NO;
        if (resp)
        {
            if (page == 1)
            {
                [_coinversionArray removeAllObjects];
            }
            
            id data = [NSObject toJSONValue:resp];
            if ([data isKindOfClass:[NSDictionary class]])
            {
                id result = [data objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]])
                {
                    id dataArray = [result objectForKey:@"data"];
                    if ([dataArray isKindOfClass:[NSArray class]] && [(NSArray*)dataArray count]>0)
                    {
                        for (NSDictionary* dict in dataArray)
                        {
                            WPConversionInfo* info = [[WPConversionInfo alloc]init];
                            info.data = dict;
                            [_coinversionArray addObject:info];
                        }
                        
                        self.page ++;
                        [self.tableview reloadData];
                    }
                }
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _coinversionArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* conversionCell = @"conversionProductCell";
    
    ConversionProductCell* cell = [tableView dequeueReusableCellWithIdentifier:conversionCell];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ConversionProductCell" owner:self options:nil]lastObject];
    }
    
    cell.conversionInfo = _coinversionArray[indexPath.row];
    
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 192;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConversionAlertView* alertView = [ConversionAlertView viewFromXib];
    alertView.conversionInfo = _coinversionArray[indexPath.row];
    alertView.delegate = self;
    [alertView renderView];
    [alertView showInWindows];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (scrollView.contentSize.height - 320 < offset.y && scrollView.isDragging)
    {
        [self prepareDateWithPage:self.page];
    }
}

- (IBAction)cancel:(id)sender
{
    [SVProgressHUD dismiss];
    [self.delegate conversionProductCancel];
}

@end
