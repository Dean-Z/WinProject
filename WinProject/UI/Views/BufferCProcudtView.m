//
//  BufferCProcudtView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BufferCProcudtView.h"
#import "WPCProductButton.h"
#import "WPProductInfo.h"

@interface BufferCProcudtView ()

@property(nonatomic, strong) NSDateFormatter* sFormatter;

@end

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
    [super renderView];
    [self prepareProductBtn];
    [self.productImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url] placeholderImage:[UIImage imageNamed:@"icon-cProduct-loading.png"]];
    self.logoLabel.text = [NSString stringWithFormat:@"品牌:%@",self.dataInfo.brand];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSInteger time = [self.dataInfo.end_time integerValue];
    NSDate *end_date = [NSDate dateWithTimeIntervalSince1970:time];
    self.endTimeLabel.text = [NSString stringWithFormat:@"有效期至:%@",[formatter stringFromDate:end_date]];
    formatter = nil;
    
    self.remainLabel.text = [NSString stringWithFormat:@"剩余：%@份",self.dataInfo.remain];
    
    self.logoLabel.hidden = YES;
    self.brandLoopView = [[MarqueeLabel alloc]initWithFrame:self.logoLabel.frame rate:20.0f andFadeLength:10];
    self.brandLoopView.font = self.logoLabel.font;
    self.brandLoopView.textColor = self.logoLabel.textColor;
    self.brandLoopView.text = self.dataInfo.brand;
    self.brandLoopView.enabled = YES;
    [self insertSubview:self.brandLoopView aboveSubview:self.logoLabel];
    
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    if (date < [self.dataInfo.start_time integerValue])
    {
        NSTimeInterval time = [self.dataInfo.start_time integerValue] - date;
        _sFormatter = [[NSDateFormatter alloc]init];
        [_sFormatter setDateFormat:@"HH:mm:ss"];
        NSDate *end_date = [NSDate dateWithTimeIntervalSince1970:time];
        self.endTimeLabel.text = [NSString stringWithFormat:@"离开抢还有:%@",[_sFormatter stringFromDate:end_date]];
        self.downTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(downTime:) userInfo:nil repeats:YES];
    }
}


- (void)downTime:(NSTimer *)timer
{
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    if (date < [self.dataInfo.start_time integerValue])
    {
        NSTimeInterval time = [self.dataInfo.start_time integerValue] - date;
        _sFormatter = [[NSDateFormatter alloc]init];
        [_sFormatter setDateFormat:@"HH:mm:ss"];
        NSDate *end_date = [NSDate dateWithTimeIntervalSince1970:time];
        self.endTimeLabel.text = [NSString stringWithFormat:@"离开抢还有:%@",[_sFormatter stringFromDate:end_date]];
    }
    else
    {
        [timer invalidate];
        timer = nil;
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSInteger time = [self.dataInfo.end_time integerValue];
        NSDate *end_date = [NSDate dateWithTimeIntervalSince1970:time];
        self.endTimeLabel.text = [NSString stringWithFormat:@"有效期至:%@",[formatter stringFromDate:end_date]];
        formatter = nil;
    }
}

- (IBAction)touched:(id)sender
{
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    if (date < [self.dataInfo.start_time integerValue])
    {
        [[WPAlertView viewFromXib] showWithMessage:@"还未到开始时间"];
        return;
    }
    self.touchButton.enabled = NO;
    [self prepareInfo:self.dataInfo.picId];
}

- (void) prepareProductBtn
{
    if(productBtn == nil)
    {
        productBtn = [WPCProductButton viewFromXib];
        productBtn.coins = [self.dataInfo.coin integerValue];
        [productBtn renderView];
        [self.productBtnContainer addSubview:productBtn];
    }
}

- (void) prepareInfo:(NSString*)productId
{
    if ([self.dataInfo.remain integerValue] == 0)
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
            detailView.productInfo = productInfo;
            detailView.delegate = self;
            [detailView renderView];
        }
    }];
}

#pragma mark WPProductDetailViewDelegate
- (void)productDownload:(WPProductInfo *)productInfo
{
    self.touchButton.enabled = YES;
    
    NSDictionary* parm = @{@"app":@"screen",@"act":@"download",@"id":productInfo.picId};
    
    __weak BufferCProcudtView *weakSelf = self;
    self.userInteractionEnabled = NO;
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id respData)
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
         [self saveDate];
         UIImage *picImage = self.productImageView.image;
         UIImageWriteToSavedPhotosAlbum(picImage, nil, nil,nil);
         [[WPAlertView viewFromXib]showWithMessage:@"保存成功"];
         
         [weakSelf.delegate downloadPicdidFinish];
         
         weakSelf.remainLabel.text = [NSString stringWithFormat:@"剩余：%d份",[self.dataInfo.remain integerValue]-1];
         self.userInteractionEnabled = YES;
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
        dateString = [NSObject toJSONString:self.dataInfo.data];
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
            if([[dict objectForKey:@"url"] isEqualToString:self.dataInfo.url])
            {
                hasDownload = YES;
                break;
            }
        }
        if(!hasDownload)
        {
            
            NSString* tmpString = [NSObject toJSONString:self.dataInfo.data];
            [productDatas setObject:tmpString forKey:[NSString stringWithFormat:@"%d",[productDatas allKeys].count]];
            dateString = [NSObject toJSONString:productDatas];
            [user setObject:dateString forKey:CORVER_DATA];
            [user synchronize];
        }
    }
}


@end
