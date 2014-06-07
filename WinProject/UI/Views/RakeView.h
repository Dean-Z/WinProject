//
//  RakeView.h
//  WinProject
//
//  Created by Dean-Z on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPSwitchBar.h"
#import "WPPullView.h"

@interface RakeView : WPBaseView<UITableViewDataSource,UITableViewDelegate>
{
    WPSwitchBar* switchBar;
    WPPullView* pullView;
    BOOL noData;
    
    NSMutableArray* _friendsRake;
    NSMutableArray* _countryRake;
}

@property(nonatomic,weak) IBOutlet UIView* switchBarContainer;
@property(nonatomic,weak) IBOutlet UITableView* friendTableView;
@property(nonatomic,weak) IBOutlet UITableView* countryTableView;

@end
