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
    
    [self prepareSwitchBar];
    
    [self prepareQScrollviewContainer];
    [self prepareCScrollviewContainer];
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
            
        }];
    }
    else
    {
        [UIView transitionWithView:self.view duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.qScrollViewController.originX = 0;
            self.cScrollViewController.originX = self.view.sizeW;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void) prepareQScrollviewContainer
{
    for (NSInteger i=0; i<6; i++)
    {
        BufferProductView* product = [BufferProductView viewFromXib];
        product.originX = i%2 * (product.sizeW + 20)+10;
        product.originY = i/2 * (product.sizeH + 20);
        [product renderView];
        [self.qScrollViewController addSubview:product];
    }
    
    [self.qScrollViewController setContentSize:CGSizeMake(0, 200*3)];
}


- (void) prepareCScrollviewContainer
{
    for (NSInteger i=0; i<3; i++)
    {
        BufferCProcudtView* cProduct = [BufferCProcudtView viewFromXib];
        cProduct.originX = (self.view.sizeW - cProduct.sizeW)/2 + self.view.sizeW*i;
        cProduct.originY = (self.cScrollViewController.sizeH - cProduct.sizeH)/2;
        [cProduct renderView];
        [self.cScrollViewController addSubview:cProduct];
    }
    
    [self.cScrollViewController setContentSize:CGSizeMake(self.view.sizeW*3, 0)];
}

- (IBAction)close:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(stockViewClose)])
    {
        [self.delegate stockViewClose];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
