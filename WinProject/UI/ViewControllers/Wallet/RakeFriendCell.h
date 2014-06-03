//
//  RakeFirendCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-3.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RakeFriendCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel* nameLabel;
@property (nonatomic,weak) IBOutlet UILabel* rakeLabel;
@property (nonatomic,weak) IBOutlet UILabel* coinLabel;

- (UIColor*)colorWithRake:(NSInteger)rake;
- (UIColor*)selfColor;

- (void)renderView;

@end
