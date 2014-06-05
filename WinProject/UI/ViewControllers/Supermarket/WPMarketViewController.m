//
//  WPMarketViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPMarketViewController.h"
#import "WPSwitchBar.h"
#import "WPMarketInfo.h"
#import "MarketInTableViewCell.h"

@interface WPMarketViewController ()
{
    WPSwitchBar* switchBar;
    WPInformationView* informationView;
    NSMutableArray* _inProductArray;
    NSMutableArray* _outProductArray;
}
@end

@implementation WPMarketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"大超市";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [self perpareSwitchBar];
    
    [self prepareData];
}

- (void) perpareSwitchBar
{
    if (switchBar == nil)
    {
        switchBar = [WPSwitchBar viewFromXib];
        [switchBar renderBarWithLeftContenct:@"进货" RightContent:@"出货" action:@selector(switchBarValueChanged) target:self];
        [self.switchBarContainer addSubview:switchBar];
    }
}

- (void)prepareData
{
    _inProductArray = [@[] mutableCopy];
    WPMarketInfo* info = [[WPMarketInfo alloc]init];
    info.cover = @"icon-invite.png";
    info.title = @"推荐好友";
    info.desc = @"推荐好友使用【赢屏】";
    info.timeLimit = @"长期有效";
    info.coins = @"20";
    [_inProductArray addObject:info];
    
    WPMarketInfo* info2 = [[WPMarketInfo alloc]init];
    info2.cover = @"icon-invite.png";
    info2.title = @"问卷调查";
    info2.desc = @"完成【赢屏】的问卷调查";
    info2.timeLimit = @"长期有效";
    info2.coins = @"20";
    [_inProductArray addObject:info2];
    
    WPMarketInfo* info3 = [[WPMarketInfo alloc]init];
    info3.cover = @"icon-invite.png";
    info3.title = @"初来咋到";
    info3.desc = @"填写完整个人信息";
    info3.timeLimit = @"长期有效";
    info3.coins = @"20";
    [_inProductArray addObject:info3];
    
    [self.productTabelView reloadData];
}

- (void) switchBarValueChanged
{
    if (switchBar.selectAtIndex == 1)
    {
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _inProductArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identity = @"ProductCell";
    
    MarketInTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MarketInTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.marketInfo = _inProductArray[indexPath.row];
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        [self showInformationView];
    }
}

- (void)showInformationView
{
    if (informationView == nil)
    {
        informationView = [WPInformationView viewFromXib];
        [self.informationViewContainer addSubview:informationView];
        [informationView renderView];
        self.informationViewContainer.originX = self.view.sizeW;
    }
    
    self.informationViewContainer.hidden = NO;
    self.refreshButton.hidden = YES;
    self.cancelButton.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.informationViewContainer.originX = 0;
        self.productTabelView.alpha = 0.0f;
        self.switchBarContainer.alpha = 0.0f;
    }];
}

- (IBAction)cancel:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.informationViewContainer.originX = self.view.sizeW;
        self.productTabelView.alpha = 1.0f;
        self.switchBarContainer.alpha = 1.0f;
    } completion:^(BOOL finished) {
        self.refreshButton.hidden = NO;
        self.cancelButton.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
