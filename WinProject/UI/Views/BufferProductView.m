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
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[self.dateInfo.exprie integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];

    self.endTimeLabel.text = [NSString stringWithFormat:@"有效期至: %@",[formatter stringFromDate:endDate]];
    [self.productImage setImageWithURL:[NSURL URLWithString:self.dateInfo.url]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定下载此壁纸" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UIImageWriteToSavedPhotosAlbum([self.productImage image], nil, nil,nil);
        [self performSelector:@selector(showSucceed) withObject:nil afterDelay:1];
    }
}

- (void)showSucceed
{
    Alert(@"保存成功");
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
