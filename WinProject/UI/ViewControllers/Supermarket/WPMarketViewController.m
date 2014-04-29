//
//  WPMarketViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPMarketViewController.h"
#import "WPSwitchBar.h"
#import "MarketInTableViewCell.h"

@interface WPMarketViewController ()
{
    WPSwitchBar* switchBar;
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

- (void) switchBarValueChanged
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identity = @"ProductCell";
    
    MarketInTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MarketInTableViewCell" owner:self options:nil]lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
