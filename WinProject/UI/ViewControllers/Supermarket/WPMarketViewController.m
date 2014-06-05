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
    info.title = @"初来咋到";
    info.desc = @"填写完整个人信息";
    info.timeLimit = @"长期有效";
    info.coins = @"20";
    [_inProductArray addObject:info];
    
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
    if (indexPath.row == 0)
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
    }
    
    self.informationViewContainer.hidden = NO;
    self.productTabelView.hidden = YES;
    self.switchBarContainer.hidden = YES;
    self.refreshButton.hidden = YES;
    self.cancelButton.hidden = NO;
}

- (IBAction)cancel:(id)sender
{
    self.informationViewContainer.hidden = YES;
    self.productTabelView.hidden = NO;
    self.switchBarContainer.hidden = NO;
    self.refreshButton.hidden = NO;
    self.cancelButton.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
