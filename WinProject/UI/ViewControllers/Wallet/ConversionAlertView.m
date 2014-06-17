//
//  ConversionAlertView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "ConversionAlertView.h"
#import "FTAnimationManager.h"
#import "WPAddressInfo.h"

@implementation ConversionAlertView

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
    
    self.addressButton.layer.cornerRadius = 3.0f;
    self.addressButton.layer.masksToBounds = YES;
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiass)]];
    
    self.productName.text = self.conversionInfo.title;
    self.needCoins.text = [NSString stringWithFormat:@"%@金币",self.conversionInfo.coins];
    
    WPUserInfo* userInfo = self.app.userInfo;
    NSInteger coins = [userInfo.coins integerValue] - [self.conversionInfo.coins integerValue];
    self.hasCoins.text = [NSString stringWithFormat:@"%d金币",coins];
    
    addressInfoArray = [@[] mutableCopy];
    addressViewArray = [@[] mutableCopy];
    [self prepareAddressData];
}

- (void)showInWindows
{
    [self.app.window addSubview:self.backgroundView];
    
    self.center = self.app.window.center;
    self.hidden = YES;
    [self.app.window addSubview:self];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (IBAction)selectCount:(id)sender
{
    WPDateSelecter* selecter = [WPDateSelecter viewFromXib];
    selecter.delegate = self;
    selecter.rowCount = 9;
    [selecter renderView];
    [selecter showInWindow];
}

- (IBAction)sure:(id)sender
{
    if (addressViewArray.count == 0)
    {
        [[WPAlertView viewFromXib]showWithMessage:@"请先添加地址"];
        return;
    }
    
    NSString* addressId = @"";
    for (WPAddressCell* cell in addressViewArray)
    {
        if (cell.isSelected)
        {
            addressId = cell.addressInfo.addressId;
            break;
        }
    }
    
    if ([NSString isNilOrEmpty:addressId])
    {
        [[WPAlertView viewFromXib]showWithMessage:@"请先选择地址"];
        return;
    }
    
    NSDictionary* parm = @{@"app":@"exchange",
                           @"act":@"do",
                           @"id":self.conversionInfo.producId,
                           @"amount":[NSString stringWithFormat:@"%d",self.amount],
                           @"address":addressId};
    
    [SVProgressHUD showWithStatus:@"正在提交.."];
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [[WPAlertView viewFromXib] showWithMessage:@"兑换成功"];
            [SVProgressHUD dismiss];
            [self dismiass];
        }
    }];
}

- (IBAction)addAddress:(id)sender
{
    WPAddressView* address = [WPAddressView viewFromXib];
    address.delegate = self;
    [address renderView];
    [address showInWindow];
}

#pragma mark WPAddressViewDelegate
- (void)addAddressDone
{
    [self prepareAddressData];
}

- (void)prepareAddressData
{
    NSDictionary* parm = @{@"app":@"address",
                           @"act":@"list"};
    
    [addressInfoArray removeAllObjects];
    [addressViewArray removeAllObjects];
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp)
    {
        if (resp)
        {
            id data = [NSObject toJSONValue:resp];
            
            if ([data isKindOfClass:[NSDictionary class]])
            {
                id result = [data objectForKey:@"result"];
                
                if ([result isKindOfClass:[NSArray class]])
                {
                    for (NSDictionary* dictData in result)
                    {
                        WPAddressInfo* info = [[WPAddressInfo alloc]init];
                        info.data = dictData;
                        [addressInfoArray addObject:info];
                    }
                    
                    [self prepareAddressView];
                }
            }
        }
    }];
}

- (void)prepareAddressView
{
    for (UIView* view in self.addressContainer.subviews)
    {
        [view removeFromSuperview];
    }
    
    self.addressContainer.sizeH = 20;
    
    for (NSInteger i=0;i<addressInfoArray.count;i++)
    {
        WPAddressInfo* info = addressInfoArray[i];
        WPAddressCell* address = [WPAddressCell viewFromXib];
        address.delegate = self;
        address.addressInfo = info;
        [address renderView];
        address.originY = i*address.sizeH;
        [self.addressContainer addSubview:address];
        
        [addressViewArray addObject:address];
    }
    
    self.addressContainer.sizeH = addressInfoArray.count * 30.0f;
    self.addressButton.originY = self.addressContainer.originY + self.addressContainer.sizeH + 10;
    self.mainScrollView.contentSize = CGSizeMake(0, self.addressButton.originY + 30);
}


#pragma mark WPAddressCellDelegate
- (void)addressCellDidSelected:(WPAddressCell *)cell
{
    for (WPAddressCell* aCell in addressViewArray)
    {
        if (aCell != cell)
        {
            aCell.isSelected = NO;
        }
    }
}

- (void)addressDeleteDone
{
    [self prepareAddressData];
}

- (void)dateSelecterAtIndex:(NSInteger)index
{
    [self.productCount setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    self.amount = index;
    
    self.needCoins.text = [NSString stringWithFormat:@"%d金币",[self.conversionInfo.coins integerValue]*index];
    
    WPUserInfo* userInfo = self.app.userInfo;
    NSInteger coins = [userInfo.coins integerValue] - [self.conversionInfo.coins integerValue]*index;
    self.hasCoins.text = [NSString stringWithFormat:@"%d金币",coins];
}

- (void)dismiass
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    [self performSelector:@selector(removerSuberViews) withObject:nil afterDelay:0.5];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = 0;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        self.centerY = self.app.window.centerY;
    }];
}


- (void) removerSuberViews
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}


@end
