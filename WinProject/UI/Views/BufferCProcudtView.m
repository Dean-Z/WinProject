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
    [self prepareProductBtn];
    [self.productImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self prepareInfo:self.dataInfo.picId];
}

- (void) prepareProductBtn
{
    if(productBtn == nil)
    {
        productBtn = [WPCProductButton viewFromXib];
        [productBtn renderView];
        [self.productBtnContainer addSubview:productBtn];
    }
}

- (void) prepareInfo:(NSString*)productId
{
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
    NSDictionary* parm = @{@"app":@"screen",@"act":@"download",@"id":productInfo.picId};
    
    [[WPSyncService alloc]downloadImageWithRoute:parm Block:^(id respData)
     {
         UIImage *picImage = [UIImage imageWithData:respData];
         UIImageWriteToSavedPhotosAlbum(picImage, nil, nil,nil);
         [[WPAlertView viewFromXib]showWithMessage:@"保存成功"];
     }];
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
