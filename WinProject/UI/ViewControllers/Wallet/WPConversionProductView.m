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
    NSDictionary* parm = @{@"app":@"exchange",@"act":@"list",@"page":[NSString stringWithFormat:@"%d",page]};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        
        [SVProgressHUD dismiss];
        
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DLog(@"%f ----- %f",scrollView.contentSize.height,scrollView.contentOffset.y);
}


- (IBAction)cancel:(id)sender
{
    [SVProgressHUD dismiss];
    [self.delegate conversionProductCancel];
}

@end
