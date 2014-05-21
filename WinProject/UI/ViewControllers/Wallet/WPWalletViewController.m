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
    
    [self dealCoinLabel];
    
    [self prepareRakeView];
    [self prepareBillView];
    
    [self.mainScrollView setContentSize:CGSizeMake(320*3, 0)];
    [self.mainScrollView setContentOffset:CGPointMake(320, 0)];
    
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

- (IBAction)share:(id)sender
{
    WPShareManager* share = [[WPShareManager alloc]init];
    [share shareWithSina:[UIImage imageNamed:@"refresh.png"] message:@"21121"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
