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
 
    [self.picImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url] placeholderImage:[UIImage imageNamed:@"icon-qProduct-loading.png"]];
    self.coinLabel.text = [NSString stringWithFormat:@"%d",[self.dataInfo.coin integerValue]];
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[self.dataInfo.end_time integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];
    
    self.endTimeLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:endDate]];
    self.typeLabel.text = [self.dataInfo.type isEqualToString:@"1"] ? @"小生意":@"大买卖";
    self.brandLabel.text = self.dataInfo.brand;
}

- (IBAction)bufferTouched:(id)sender
{
    [self.delegate bufferCategoryViewTouched:self.dataInfo];
}

@end
