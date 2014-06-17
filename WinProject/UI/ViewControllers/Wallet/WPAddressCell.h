//
//  WPAddressCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPAddressInfo.h"

@protocol WPAddressCellDelegate;
@interface WPAddressCell : WPBaseView

@property(nonatomic,weak) IBOutlet UILabel* address;
@property(nonatomic,weak) IBOutlet UIImageView* stautsBtn;
@property(nonatomic,assign) id<WPAddressCellDelegate> delegate;
@property(nonatomic,strong) WPAddressInfo* addressInfo;
@property(nonatomic,assign) BOOL isSelected;
@end

@protocol WPAddressCellDelegate <NSObject>

- (void)addressCellDidSelected:(WPAddressCell*)cell;
- (void)addressDeleteDone;

@end