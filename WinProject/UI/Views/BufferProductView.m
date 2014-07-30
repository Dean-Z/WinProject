//
//  BufferProductView.m
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BufferProductView.h"
#import "WPProductInfo.h"

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
    [super renderView];
    [self prepareProductButton];
    
    NSDate* endDate = [NSDate dateWithTimeIntervalSince1970:[self.dateInfo.end_time integerValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-dd"];

    self.endTimeLabel.text = [NSString stringWithFormat:@"有效期至: %@",[formatter stringFromDate:endDate]];
    [self.productImage setImageWithURL:[NSURL URLWithString:self.dateInfo.url] placeholderImage:[UIImage imageNamed:@"icon-qProduct-loading.png"]];
    self.numberProductLabel.text = [NSString stringWithFormat:@"%@份",self.dateInfo.remain];
    self.numberProductLabel.hidden = YES;
    
    self.brandLoopView = [[MarqueeLabel alloc]initWithFrame:self.numberProductLabel.frame rate:20.0f andFadeLength:5];
    self.brandLoopView.textAlignment = NSTextAlignmentCenter;
    self.brandLoopView.font = self.numberProductLabel.font;
    self.brandLoopView.textColor = self.numberProductLabel.textColor;
    self.brandLoopView.text = self.numberProductLabel.text;
    self.brandLoopView.enabled = YES;
    [self insertSubview:self.brandLoopView aboveSubview:self.numberProductLabel];

}

- (IBAction)touched:(id)sender
{
    self.touchButton.enabled = NO;
    [self prepareInfo:self.dateInfo.picId];
}

#pragma mark WPProductDetailViewDelegate
- (void)productDownload:(WPProductInfo *)productInfo
{
    NSDictionary* parm = @{@"app":@"screen",@"act":@"download",@"id":productInfo.picId};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id respData)
     {
         if (respData)
        {
            id resp = [NSObject toJSONValue:respData];
            if ([resp isKindOfClass:[NSDictionary class]])
            {
                if ([[resp objectForKey:@"state"] intValue] == 1)
                {
                    id result = resp[@"result"];
                    self.app.userInfo.coins = [result objectForKey:@"balance"];
                }
            }
            DLog(@"%@",respData);
        }
         [self saveDate];
         UIImage *picImage = self.productImage.image;
         UIImageWriteToSavedPhotosAlbum(picImage, nil, nil,nil);
         [[WPAlertView viewFromXib]showWithMessage:@"保存成功"];
         
         [self.delegate downloadPicdidFinish];
    }];
}

- (void)productCancel:(WPProductInfo *)productInfo
{
    self.touchButton.enabled = YES;
}

- (void)saveDate
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    NSString* dateString = [user objectForKey:CORVER_DATA];
    
    if([NSString isNilOrEmpty:dateString])
    {
        NSMutableDictionary* productDatas = [@{} mutableCopy];
        dateString = [NSObject toJSONString:self.dateInfo.data];
        [productDatas setObject:dateString forKey:@"0"];
        dateString = [NSObject toJSONString:productDatas];
        [user setObject:dateString forKey:CORVER_DATA];
        [user synchronize];
        return;
    }
    
    id dataDict = [NSObject toJSONValue:dateString];
    
    if([dataDict isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary* productDatas = [NSMutableDictionary dictionaryWithDictionary:dataDict];
        
        BOOL hasDownload = NO;
        for(NSInteger i=0;i<[productDatas allKeys].count;i++)
        {
            NSDictionary* dict = (NSDictionary*)[NSObject toJSONValue:productDatas[[productDatas allKeys][i]]];
            if([[dict objectForKey:@"url"] isEqualToString:self.dateInfo.url])
            {
                hasDownload = YES;
                break;
            }
        }
        if(!hasDownload)
        {
            
            NSString* tmpString = [NSObject toJSONString:self.dateInfo.data];
            [productDatas setObject:tmpString forKey:[NSString stringWithFormat:@"%d",[productDatas allKeys].count]];
            dateString = [NSObject toJSONString:productDatas];
            [user setObject:dateString forKey:CORVER_DATA];
            [user synchronize];
        }
    }
}

- (void) prepareProductButton
{
    if (productBtn == nil)
    {
        productBtn = [WPProductButton viewFromXib];
        productBtn.coins = [self.dateInfo.coin integerValue];
        [productBtn renderView];
        [self.priceBtnContainer addSubview:productBtn];
    }
}

- (void) prepareInfo:(NSString*)productId
{
    if ([self.dateInfo.remain integerValue] == 0)
    {
        [[WPAlertView viewFromXib] showWithMessage:@"已售完"];
        return;
    }
    
    NSDictionary* term = @{@"app":@"screen",@"act":@"info",@"id":productId};
    
    [[WPSyncService alloc]syncWithRoute:term Block:^(id resp) {
        
        if (resp)
        {
            WPProductInfo* productInfo = [[WPProductInfo alloc]init];
            [productInfo setRowDate:resp];
            
            WPProductDetailView* detailView = [WPProductDetailView viewFromXib];
            detailView.delegate = self;
            detailView.productInfo = productInfo;
            [detailView renderView];
        }
    }];
}

@end
