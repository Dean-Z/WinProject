//
//  WPWalletViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPWalletViewController.h"
#import "WPShareManager.h"

@interface WPWalletViewController ()
{
    RakeView* rakeView;
    BillView* billView;
    WPConversionView* conversionView;
    WPAlipayView* alipayView;
    WPConversionProductView* conversionProductView;
}
@end

@implementation WPWalletViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"收钱柜";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];

    [self.exchangeButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:21]];
    [self.shareButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:21]];
    
    if ([NSString isNilOrEmpty:self.app.userInfo.coins])
    {
      self.coinLabel.text = @"0.0";
    }
    else
    {
        self.coinLabel.text = self.app.userInfo.coins;
    }
    
    if ([NSString isNilOrEmpty:self.app.userInfo.nickname])
        self.titleLabel.text = @"收钱柜";
    else
        self.titleLabel.text = self.app.userInfo.nickname;
    
    [self dealCoinLabel];
    
    [self prepareRakeView];
    [self prepareBillView];
    
    [self.mainScrollView setContentSize:CGSizeMake(320*3, 0)];
    [self.mainScrollView setContentOffset:CGPointMake(320, 0)];
    
}

- (void)updateUserInfo
{
    self.titleLabel.text = self.app.userInfo.nickname;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) dealCoinLabel
{
    CGSize size = [self.coinLabel.text sizeWithFont:self.coinLabel.font constrainedToSize:CGSizeMake(160, 40) lineBreakMode:self.coinLabel.lineBreakMode];
    
    self.coinLabel.sizeW = size.width;
    
    CGFloat containerWidth = self.coinLabel.sizeW+ self.yuanLabel.sizeW;
    
    self.coinLabel.originX = self.view.sizeW + (self.view.sizeW-containerWidth)/2;
    self.yuanLabel.originX = self.coinLabel.sizeW + self.coinLabel.originX+3.0f;
}

- (void) prepareRakeView
{
    if (rakeView == nil)
    {
        rakeView = [RakeView viewFromXib];
        rakeView.originX = (self.view.sizeW - rakeView.sizeW)/2;
        rakeView.originY = (self.view.sizeH - 108 - rakeView.sizeH)/2;
        [rakeView renderView];
        [self.mainScrollView addSubview:rakeView];
    }
}


- (void) prepareBillView
{
    if (billView == nil)
    {
        billView = [BillView viewFromXib];
        billView.originX = self.view.sizeW*2 + (self.view.sizeW - billView.sizeW)/2;
        billView.originY = (self.view.sizeH - 108 - billView.sizeH)/2;
        [billView renderView];
        [self.mainScrollView addSubview:billView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat bgOriginX =  -(scrollView.contentOffset.x*self.bgImageView.sizeW)/(320*4);
    if (bgOriginX>0)
    {
        bgOriginX = 0;
    }
    else if(bgOriginX < -(self.bgImageView.sizeW - self.view.sizeW))
    {
        bgOriginX = -(self.bgImageView.sizeW - self.view.sizeW);
    }
    self.bgImageView.originX = bgOriginX;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0)
    {
        [rakeView prepareData];
    }
    else if (scrollView.contentOffset.x/320 == 2)
    {
        [billView prepareData];
    }
}

- (IBAction)share:(id)sender
{
    WPShareManager* share = [[WPShareManager alloc]init];
    [share shareWithSina:[UIImage imageNamed:@"refresh.png"] message:@"21121"];
}

- (IBAction)conversion:(id)sender
{
    [self showConversionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark About ConversionView

- (void)prepareConversionView
{
    if (conversionView == nil)
    {
        conversionView = [WPConversionView viewFromXib];
        conversionView.sizeH = self.view.sizeH;
        conversionView.delegate = self;
        conversionView.originX = self.view.sizeW;
        [self.view addSubview:conversionView];
        [conversionView renderView];
    }
}

- (void)showConversionView
{
    [self prepareConversionView];
    
    [UIView animateWithDuration:0.3 animations:^{
        conversionView.originX = 0;
        self.mainScrollView.alpha = 0.0f;
    }];
}

- (void)conversionSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self showAlipayView];
    }
    else if(index == 1)
    {
        [self showConversionProudctView];
    }
}

- (void)conversionCancel
{
    [UIView animateWithDuration:0.3 animations:^{
        conversionView.originX = self.view.sizeW;
        self.mainScrollView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [conversionView removeFromSuperview];
        conversionView = nil;
    }];
}

#pragma mark About AlipayView

- (void)prepareAlipayView
{
    if (alipayView == nil)
    {
        alipayView = [WPAlipayView viewFromXib];
        alipayView.sizeH = self.view.sizeH;
        alipayView.delegate = self;
        alipayView.originX = self.view.sizeW;
        [self.view addSubview:alipayView];
        [alipayView renderView];
    }
}

- (void)alipayCancel
{
    [UIView animateWithDuration:0.3 animations:^{
        conversionView.alpha = 1.0f;
        alipayView.originX = self.view.sizeW;
    } completion:^(BOOL finished) {
        [alipayView removeFromSuperview];
        alipayView = nil;
    }];
}

- (void)showAlipayView
{
    [self prepareAlipayView];
    
    [UIView animateWithDuration:0.3 animations:^{
        alipayView.originX = 0;
        conversionView.alpha = 0.0f;
    }];
}

#pragma mark About ConversionProductView

- (void)prepareConversionProudctView
{
    if (conversionProductView == nil)
    {
        conversionProductView = [WPConversionProductView viewFromXib];
        conversionProductView.sizeH = self.view.sizeH;
        conversionProductView.originX = self.view.sizeW;
        conversionProductView.delegate = self;
        [conversionProductView renderView];
        [self.view addSubview:conversionProductView];
    }
}

- (void)showConversionProudctView
{
    [self prepareConversionProudctView];
    
    [UIView animateWithDuration:0.3 animations:^{
        conversionProductView.originX = 0;
        conversionView.alpha = 0.0f;
    }];
}

- (void)conversionProductCancel
{
    [UIView animateWithDuration:0.3 animations:^{
        conversionView.alpha = 1.0f;
        conversionProductView.originX = self.view.sizeW;
    } completion:^(BOOL finished) {
        [conversionProductView removeFromSuperview];
        conversionProductView = nil;
    }];
}

@end
