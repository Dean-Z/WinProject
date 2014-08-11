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
    BOOL  isInProduct;
}
@end

@implementation WPMarketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"有奖竞答";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _inProductArray = [@[] mutableCopy];
    _outProductArray = [@[] mutableCopy];
    
    isInProduct = YES;
    [self perpareSwitchBar];
    [self prepareData];
}

- (void) perpareSwitchBar
{
    if (switchBar == nil)
    {
        switchBar = [WPSwitchBar viewFromXib];
        [switchBar renderBarWithLeftContenct:@"做任务" RightContent:@"任务仓库" action:@selector(switchBarValueChanged) target:self];
        [self.switchBarContainer addSubview:switchBar];
    }
}

- (void)prepareData
{
    [_inProductArray removeAllObjects];
    [_outProductArray removeAllObjects];
    
    WPMarketInfo* info = [[WPMarketInfo alloc]init];
    info.cover = @"icon-invite.png";
    info.title = @"推荐好友";
    info.desc = @"推荐好友使用【聚宝屏】";
    info.timeLimit = @"长期有效";
    info.coins = @"20";
    info.type = Market_Invite_Type;
    [_inProductArray addObject:info];
    
    WPMarketInfo* info3 = [[WPMarketInfo alloc]init];
    info3.title = @"初来咋到";
    info3.desc = @"填写完整个人信息";
    info3.timeLimit = @"长期有效";
    info3.coins = @"20";
    info3.type = Market_Information_Type;
    if ([self.app.userInfo.complete isEqualToString:@"1"])
    {
        info3.cover = @"icon-information-2.png";
        info3.completion = YES;
        [_inProductArray addObject:info3];
    }
    else
    {
        info3.completion = NO;
        info3.cover = @"icon-information.png";
        [_inProductArray addObject:info3];
    }

    [self.productTabelView reloadData];
    
    NSDictionary* parm = @{@"app":@"survey",@"act":@"index",@"page":@"1"};
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            self.inPage = 2;
            id data = [NSObject toJSONValue:resp];
            
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* result = [data objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSArray* questionArray = [result objectForKey:@"data"];
                    for (NSDictionary* dict in questionArray)
                    {
                        WPMarketInfo* info = [[WPMarketInfo alloc]init];
                        info.question_id = [dict objectForKey:@"id"];
                        info.cover = [dict objectForKey:@"logo"];
                        info.title = [dict objectForKey:@"title"];
                        info.desc = [dict objectForKey:@"description"];
                        info.end_time = [dict objectForKey:@"end_time"];
                        info.coins = [dict objectForKey:@"coins"];
                        info.type = Market_Question_Type;
                        [_inProductArray addObject:info];
                        info = nil;
                    }
                    
                     [self.productTabelView reloadData];
                }
            }
        }
    }];
    
    
    NSDictionary* outParm = @{@"app":@"survey",@"act":@"expired",@"page":@"1"};
    [[WPSyncService alloc]syncWithRoute:outParm Block:^(id resp) {
        if (resp)
        {
            self.outPage = 2;
            id data = [NSObject toJSONValue:resp];
            
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* result = [data objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSArray* questionArray = [result objectForKey:@"data"];
                    for (NSDictionary* dict in questionArray)
                    {
                        WPMarketInfo* info = [[WPMarketInfo alloc]init];
                        info.question_id = [dict objectForKey:@"id"];
                        info.cover = [dict objectForKey:@"logo"];
                        info.title = [dict objectForKey:@"title"];
                        info.desc = [dict objectForKey:@"description"];
                        info.end_time = [dict objectForKey:@"end_time"];
                        info.coins = [dict objectForKey:@"coins"];
                        info.type = Market_Question_Type;
                        [_outProductArray addObject:info];
                        info = nil;
                    }
                    
                    [self.productTabelView reloadData];
                }
            }
        }
    }];
}

- (void) switchBarValueChanged
{
    if (switchBar.selectAtIndex == 0)
    {
        isInProduct = YES;
    }
    else
    {
        isInProduct = NO;
    }
    
    [self.productTabelView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isInProduct)
    {
        return _inProductArray.count;
    }
    return _outProductArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* identity = @"ProductCell";
    
    MarketInTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identity];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MarketInTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (isInProduct)
    {
        cell.marketInfo = _inProductArray[indexPath.row];
    }
    else
    {
        cell.marketInfo = _outProductArray[indexPath.row];
    }
    
    [cell renderCell];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketInTableViewCell* cell = (MarketInTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (!isInProduct && cell.marketInfo.type != Market_Invite_Type)
    {
        return;
    }
    
    if (cell.marketInfo.type == Market_Invite_Type)
    {
        WPInviteView* invite = [WPInviteView viewFromXib];
        invite.delegate = self;
        [invite renderView];
    }
    else if (cell.marketInfo.type == Market_Information_Type)
    {
        if (cell.marketInfo.completion)
        {
            return;
        }
        [self showInformationView];
    }
    else if(cell.marketInfo.type == Market_Question_Type)
    {
        __weak WPMarketViewController* market = self;
        NSDictionary* parm = @{@"app":@"survey",@"act":@"info",@"id":cell.marketInfo.question_id};
        [SVProgressHUD showWithStatus:@"正在加载"];
        self.view.userInteractionEnabled = NO;
        [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
            if (resp)
            {
                id data = [NSObject toJSONValue:resp];
                
                if ([data isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary* result = [data objectForKey:@"result"];
                    WPQuestionViewController* question = [[WPQuestionViewController alloc]viewControllerFromXib];
                    question.delegate = market;
                    question.questionId = cell.marketInfo.question_id;
                    question.requestResult = result;
                    [market.app.aTabBarController.navigationController pushViewController:question animated:YES];
                    market.view.userInteractionEnabled = YES;
                    question = nil;
                }
            }
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)showInformationView
{
    if (informationView == nil)
    {
        informationView = [WPInformationView viewFromXib];
        informationView.delegate = self;
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

- (IBAction)refresh:(id)sender
{
    [self prepareData];
}

#pragma mark WPInformationViewDelegate
- (void)completeInformation
{
    [_outProductArray addObject:[_inProductArray lastObject]];
    [_inProductArray removeObject:[_inProductArray lastObject]];
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    [user setObject:MARKET_INFORMATION forKey:MARKET_INFORMATION];
    [user synchronize];
    [self cancel:nil];
    [self.productTabelView reloadData];
}

#pragma mark WPInviteViewDelegate
- (void)inviteSucceed
{
//    [_outProductArray addObject:[_inProductArray firstObject]];
//    [_inProductArray removeObject:[_inProductArray firstObject]];
//    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
//    [user setObject:MARKET_INVITE forKey:MARKET_INVITE];
//    [user synchronize];
//    [self.productTabelView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (scrollView.contentSize.height - 320 < offset.y && scrollView.isDragging)
    {
        if (isInProduct)
        {
            [self loadMoreInSurvey];
        }
        else
        {
            [self loadMoreOutSurvey];
        }
    }
}

- (void)loadMoreInSurvey
{
    if (self.inPageLoading)
    {
        return;
    }
    self.inPageLoading = YES;
    NSDictionary* parm = @{@"app":@"survey",
                           @"act":@"index",
                           @"page":[NSString stringWithFormat:@"%d",self.inPage]};
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            id data = [NSObject toJSONValue:resp];
            
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* result = [data objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSArray* questionArray = [result objectForKey:@"data"];
                    for (NSDictionary* dict in questionArray)
                    {
                        WPMarketInfo* info = [[WPMarketInfo alloc]init];
                        info.question_id = [dict objectForKey:@"id"];
                        info.cover = [dict objectForKey:@"logo"];
                        info.title = [dict objectForKey:@"title"];
                        info.desc = [dict objectForKey:@"description"];
                        info.end_time = [dict objectForKey:@"end_time"];
                        info.coins = [dict objectForKey:@"coins"];
                        info.type = Market_Question_Type;
                        [_inProductArray addObject:info];
                        info = nil;
                    }
                    if (questionArray.count>0)
                    {
                        self.inPage++;
                    }
                    [self.productTabelView reloadData];
                }
            }
        }
        self.inPageLoading = NO;
    }];
}

- (void)loadMoreOutSurvey
{
    if (self.outPageLoading)
    {
        return;
    }
    
    self.outPageLoading = YES;
    NSDictionary* outParm = @{@"app":@"survey",
                              @"act":@"expired",
                              @"page":[NSString stringWithFormat:@"%d",self.outPage]};
    [[WPSyncService alloc]syncWithRoute:outParm Block:^(id resp) {
        if (resp)
        {
            id data = [NSObject toJSONValue:resp];
            
            if ([data isKindOfClass:[NSDictionary class]])
            {
                NSDictionary* result = [data objectForKey:@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSArray* questionArray = [result objectForKey:@"data"];
                    for (NSDictionary* dict in questionArray)
                    {
                        WPMarketInfo* info = [[WPMarketInfo alloc]init];
                        info.question_id = [dict objectForKey:@"id"];
                        info.cover = [dict objectForKey:@"logo"];
                        info.title = [dict objectForKey:@"title"];
                        info.desc = [dict objectForKey:@"description"];
                        info.end_time = [dict objectForKey:@"end_time"];
                        info.coins = [dict objectForKey:@"coins"];
                        info.type = Market_Question_Type;
                        [_outProductArray addObject:info];
                        info = nil;
                    }
                    if (questionArray.count>0)
                    {
                        self.outPage++;
                    }
                    [self.productTabelView reloadData];
                }
            }
            self.outPageLoading = NO;
        }
    }];
}

- (void)finishQuestion:(NSString *)questionId
{
    [self prepareData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
