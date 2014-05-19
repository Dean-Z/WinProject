//
//  WPSettingViewController.h
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPSettingViewController : BaseXibViewController

@property (nonatomic,weak) IBOutlet UIScrollView* scrollViewContainer;
@property (nonatomic,weak) IBOutlet UIView* cell2Container;
@property (nonatomic,weak) IBOutlet UIView* cell3Container;

@property (nonatomic,strong) NSString* urlString;

@end
