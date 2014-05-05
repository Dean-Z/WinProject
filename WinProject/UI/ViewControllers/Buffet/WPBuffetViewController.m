//
//  WPBuffetViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBuffetViewController.h"

@interface WPBuffetViewController ()
{
    WPStockViewController* stock;
}
@end

@implementation WPBuffetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"小卖部";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}


- (IBAction)stockAction:(id)sender
{
    if (stock == nil)
    {
        stock = [[WPStockViewController alloc]viewControllerFromXib];
        stock.delegate = self;
        stock.view.originX = self.view.sizeW;
        [self.view addSubview:stock.view];
    }
    
    [UIView transitionWithView:stock.view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        stock.view.originX = 0;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) stockViewClose
{
    if (stock)
    {
        [UIView transitionWithView:stock.view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            stock.view.originX = self.view.sizeW;
        } completion:^(BOOL finished) {
            [stock.view removeFromSuperview];
            stock = nil;
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
