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
    BOOL loadContry;
    BOOL loadFriends;
    NSMutableArray* _friendsRake;
    NSMutableArray* _countryRake;
}

@property(nonatomic,weak) IBOutlet UILabel* positionLabel;
@property(nonatomic,weak) IBOutlet UILabel* rateLabel;
@property(nonatomic,weak) IBOutlet UILabel* gapLabel;
@property(nonatomic,weak) IBOutlet UIView* switchBarContainer;
@property(nonatomic,weak) IBOutlet UITableView* friendTableView;
@property(nonatomic,weak) IBOutlet UITableView* countryTableView;
@property(nonatomic,strong) NSDictionary* resultDict;

- (void)prepareData;

@end
