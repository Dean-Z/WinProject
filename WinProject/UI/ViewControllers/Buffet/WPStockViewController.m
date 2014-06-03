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
    WPQDateInfo* qDataInfo;
    WPCDataInfo* cDataInfo;
}
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
            if (cDataInfo.cBaseDateArray.count>0)
            {
                self.nextButton.hidden = NO;
                self.preButton.hidden = NO;
            }
        }];
        
        [[WPSyncService alloc]syncWithRoute:@{@"app":@"screen",@"act":@"index",@"phone":self.app.phoneNumber,@"page":@"1",@"type":@"0"} Block:^(id resp) {
            if (resp)
            {
                cDataInfo = [[WPCDataInfo alloc]init];
                cDataInfo.rowDate = resp;
                [self prepareCScrollviewContainer];
                
                if (cDataInfo.cBaseDateArray.count>0)
                {
                    self.nextButton.hidden = NO;
                    self.preButton.hidden = NO;
                }
            }
            else
            {
                if (cDataInfo == nil)
                {
                    self.nextButton.hidden = YES;
                    self.preButton.hidden = YES;
                }
            }
        }];
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
        
        [[WPSyncService alloc]syncWithRoute:@{@"app":@"screen",@"act":@"index",@"phone":self.app.phoneNumber,@"page":@"1",@"type":@"1"} Block:^(id resp) {
            if (resp)
            {
                qDataInfo = [[WPQDateInfo alloc]init];
                qDataInfo.rowDate = resp;
                [self prepareQScrollviewContainer];
            }
            else
            {
            }
        }];
    }
}

- (void) prepareQScrollviewContainer
{
    for (NSInteger i=0; i<qDataInfo.qBaseDateArray.count; i++)
    {
        BufferProductView* product = [BufferProductView viewFromXib];
        product.dateInfo = qDataInfo.qBaseDateArray[i];
        product.originX = i%2 * (product.sizeW + 20)+10;
        product.originY = i/2 * (product.sizeH + 20);
        [product renderView];
        [self.qScrollViewController addSubview:product];
    }
    
    [self.qScrollViewController setContentSize:CGSizeMake(0, 200*qDataInfo.qBaseDateArray.count)];
}


- (void) prepareCScrollviewContainer
{
    for (NSInteger i=0; i<cDataInfo.cBaseDateArray.count; i++)
    {
        BufferCProcudtView* cProduct = [BufferCProcudtView viewFromXib];
        cProduct.dataInfo = cDataInfo.cBaseDateArray[i];
        cProduct.originX = (self.view.sizeW - cProduct.sizeW)/2 + self.view.sizeW*i;
        cProduct.originY = IS_IPHONE_5 ?(self.cScrollViewController.sizeH - cProduct.sizeH)/2 : 10;
        [cProduct renderView];
        [self.cScrollViewController addSubview:cProduct];
    }
    
    [self.cScrollViewController setContentSize:CGSizeMake(self.view.sizeW*cDataInfo.cBaseDateArray.count, 0)];
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
        if (cCurrentPage<2)
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
    else if(cCurrentPage == cDataInfo.cBaseDateArray.count-1)
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

@end
