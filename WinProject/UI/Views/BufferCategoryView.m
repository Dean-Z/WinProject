//
//  BufferCategoryView.m
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BufferCategoryView.h"
#import "UIImageView+WebCache.h"

@implementation BufferCategoryView

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
 
    [self.picImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url]];
    self.coinLabel.text = self.dataInfo.coin;
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[self.dataInfo.exprie integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    
    self.endTimeLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    
    self.typeLabel.text = [self.dataInfo.type isEqualToString:@"1"] ? @"切糕":@"茶叶蛋";
    self.brandLabel.text = self.dataInfo.title;
}

@end
