//
//  WPAddressCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAddressCell.h"

@implementation WPAddressCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    self.address.text = self.addressInfo.address;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate addressCellDidSelected:self];
    self.isSelected = YES;
    self.stautsBtn.image = [UIImage imageNamed:@"icon-selected.png"];
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (_isSelected)
    {
        self.stautsBtn.image = [UIImage imageNamed:@"icon-selected.png"];
    }
    else
    {
        self.stautsBtn.image = [UIImage imageNamed:@"icon-normal.png"];
    }
}

- (IBAction)deleteAction:(id)sender
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确认删除该地址" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert = nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSDictionary* parm = @{@"app":@"address",
                               @"act":@"delete",
                               @"id":self.addressInfo.addressId};
        
        __weak WPAddressCell* cell = self;
        [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
            if (resp)
            {
                [cell.delegate addressDeleteDone];
                [[WPAlertView viewFromXib] showWithMessage:@"删除成功"];
            }
        }];
    }
}

@end
