//
//  WPPullView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPRakeInfo.h"

@interface WPPullView : WPBaseView<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isPull;
}

@property(nonatomic,weak) IBOutlet UILabel* firstCellLabel;
@property(nonatomic,weak) IBOutlet UITableView* tableview;
@property(nonatomic,weak) IBOutlet UIImageView* pullViewNormal;
@property(nonatomic,weak) IBOutlet UIImageView* pullViewSelected;
@property(nonatomic,strong) NSMutableArray* historyData;
@property(nonatomic,strong) WPRakeInfo* rakeInfo;


- (void)fillDate;

@end
