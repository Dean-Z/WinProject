//
//  WPGoodsInfo.m
//  WinProject
//
//  Created by Dean-Z on 14-8-24.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPGoodsInfo.h"

@implementation WPGoodsInfo

- (NSDictionary *) goodsMapping
{
    if (!_goodsMapping)
    {
        _goodsMapping = @{@"title":@"title",@"logo":@"logo",
                              @"type":@"type",@"description":@"description",
                              @"coins":@"coins",@"amount":@"amount",
                              @"remain":@"remain",@"status":@"status",
                          };
    }
    
    return _goodsMapping;
}

@end
