//
//  WPStockViewController.m
//  WinProject
//
//  Created by Dean-Z on 14-5-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPStockViewController.h"

@interface WPStockViewController ()
{
    WPSwitchBar* switchBar;
    NSInteger cCurrentPage;
}

@property (nonatomic,strong) NSMutableArray* cDataArray;
@property (nonatomic,strong) NSMutableArray* qDataArray;

@end

@implementation WPStockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cCurrentPage = 0;
    self.cDataArray = [@[] mutableCopy];
    self.qDataArray = [@[] mutableCopy];
    
    [self prepareSwitchBar];
    switchBar.selectAtIndex = 0;
    [self switchBarSelected];
}

- (void)prepareSwitchBar
{
    if (switchBar == nil)
    {
        switchBar = [WPSwitchBar viewFromXib];
        [switchBar renderBarWithLeftContenct:@"切糕" RightContent:@"茶叶蛋" action:@selector(switchBarSelected) target:self];
        [self.switchBarContainer addSubview:switchBar];
    }
}

- (void) switchBarSelected
{
    if (switchBar.selectAtIndex == 1)
    {
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.qScrollViewController.originX = -self.view.sizeW;
            self.cScrollViewController.originX = 0;
        } completion:^(BOOL finished) {
            if (self.cDataArray.count>0)
            {
                self.nextButton.hidden = NO;
                self.preButton.hidden = NO;
            }
        }];
        
        if (self.cDataArray.count == 0)
        {
            [SVProgressHUD showWithStatus:@"正在加载"];
            [[WPSyncService alloc]syncWithRoute:@{@"app":@"screen",@"act":@"index",@"phone":self.app.phoneNumber,@"page":@"1",@"type":@"0"} Block:^(id resp) {
                [SVProgressHUD dismiss];
                if (resp)
                {
                   WPCDataInfo* cDataInfo = [[WPCDataInfo alloc]init];
                    cDataInfo.rowDate = resp;
                    self.cDataArray = [NSMutableArray arrayWithArray:cDataInfo.cBaseDateArray];
                    [self prepareCScrollviewContainer];
                    
                    if (cDataInfo.cBaseDateArray.count>0)
                    {
                        self.nextButton.hidden = NO;
                        self.preButton.hidden = NO;
                        self.cNoDataImageView.hidden = YES;
                    }
                    else
                    {
                        self.cNoDataImageView.hidden = NO;
                    }
                }
                else
                {
                    if (self.cDataArray.count == 0)
                    {
                        self.nextButton.hidden = YES;
                        self.preButton.hidden = YES;
                        self.cNoDataImageView.hidden = NO;
                    }
                }
            }];
        }
    }
    else
    {
        self.nextButton.hidden = YES;
        self.preButton.hidden = YES;
        
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.qScrollViewController.originX = 0;
            self.cScrollViewController.originX = self.view.sizeW;
        } completion:^(BOOL finished) {
            
        }];
        
        if (self.qDataArray.count == 0)
        {
            [SVProgressHUD showWithStatus:@"正在加载"];
            [[WPSyncService alloc]syncWithRoute:@{@"app":@"screen",@"act":@"index",@"phone":self.app.phoneNumber,@"page":@"1",@"type":@"1"} Block:^(id resp) {
                [SVProgressHUD dismiss];
                if (resp)
                {
                    WPQDateInfo *qDataInfo = [[WPQDateInfo alloc]init];
                    qDataInfo.rowDate = resp;
                    self.qDataArray = [NSMutableArray arrayWithArray:qDataInfo.qBaseDateArray];
                    [self prepareQScrollviewContainer];
                    self.qNoDataImageView.hidden = YES;
                }
                
                if (self.qDataArray.count == 0)
                {
                    self.qNoDataImageView.hidden = NO;
                }
            }];
        }
        
    }
}

- (void) prepareQScrollviewContainer
{
    for (NSInteger i=0; i<self.qDataArray.count; i++)
    {
        BufferProductView* product = [BufferProductView viewFromXib];
        product.dateInfo = self.qDataArray[i];
        product.originX = i%2 * (product.sizeW + 20)+10;
        product.originY = i/2 * (product.sizeH + 20);
        [product renderView];
        [self.qScrollViewController addSubview:product];
    }
    
    [self.qScrollViewController setContentSize:CGSizeMake(0, MAX(self.view.sizeH, 180*(self.qDataArray.count/2+1)))];
}


- (void) prepareCScrollviewContainer
{
    for (NSInteger i=0; i<self.cDataArray.count; i++)
    {
        BufferCProcudtView* cProduct = [BufferCProcudtView viewFromXib];
        cProduct.dataInfo = self.cDataArray[i];
        cProduct.originX = (self.view.sizeW - cProduct.sizeW)/2 + self.view.sizeW*i;
        cProduct.originY = IS_IPHONE_5 ?(self.cScrollViewController.sizeH - cProduct.sizeH)/2 : 10;
        [cProduct renderView];
        [self.cScrollViewController addSubview:cProduct];
    }
    
    [self.cScrollViewController setContentSize:CGSizeMake(self.view.sizeW*self.cDataArray.count, 0)];
}

- (IBAction)close:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(stockViewClose)])
    {
        [self.delegate stockViewClose];
    }
}

- (IBAction)pageAction:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    if (button ==  self.nextButton)
    {
        if (cCurrentPage<self.cDataArray.count-1)
        {
            cCurrentPage++;
        }
    }
    else if(button == self.preButton)
    {
        if (cCurrentPage>0)
        {
            cCurrentPage--;
        }
    }
    
    [self resetButtons];
    
    [self.cScrollViewController setContentOffset:CGPointMake(cCurrentPage*self.view.sizeW, 0) animated:YES];
}

- (void) resetButtons
{
    if (cCurrentPage == 0)
    {
        [self.preButton setImage:[UIImage imageNamed:@"btn_gray_pre.png"] forState:UIControlStateNormal];
    }
    else if(cCurrentPage == self.cDataArray.count-1)
    {
        [self.nextButton setImage:[UIImage imageNamed:@"btn_gray_next.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.nextButton setImage:[UIImage imageNamed:@"btn_next.png"] forState:UIControlStateNormal];
        [self.preButton setImage:[UIImage imageNamed:@"btn_pre.png"] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.cScrollViewController)
    {
        NSInteger currentPage = self.cScrollViewController.contentOffset.x/self.view.sizeW;
        cCurrentPage = currentPage;
        
        [self resetButtons];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void) loadMoreCProduct:(NSInteger)page
{
    [[WPSyncService alloc]syncWithRoute:@{@"app":@"screen",
                                          @"act":@"index",
                                          @"phone":self.app.phoneNumber,
                                          @"page":[NSString stringWithFormat:@"%d",page],
                                          @"type":@"0"}
                                  Block:^(id resp) {
                                      if (resp)
                                      {
                                          
                                      }
                                  }];
}

@end
