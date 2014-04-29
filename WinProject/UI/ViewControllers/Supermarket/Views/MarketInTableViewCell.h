//
//  MarketInTableViewCell.h
//  WinProject
//
//  Created by Dean on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketInTableViewCell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIView* cellbgView;

- (void) renderCell;

@end
