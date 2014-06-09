//
//  WPBuffetViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBuffetViewController.h"
#import "BufferCategoryView.h"

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
    
    [self prepareProductContainerView];
}

- (void)prepareProductContainerView
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    NSString* dataString = [user objectForKey:CORVER_DATA];
    
    if([NSString isNilOrEmpty:dataString]) return;
    
    id dataDict = [NSObject toJSONValue:dataString];
    
    NSMutableArray* dataInfoArray = [@[] mutableCopy];
    
    if([dataDict isKindOfClass:[NSDictionary class]])
    {
        for(NSInteger i=0;i<[dataDict allKeys].count;i++)
        {
            WPCBaseDateInfo* dateInfo = [[WPCBaseDateInfo alloc]init];
            dateInfo.data = (NSDictionary*)[NSObject toJSONValue:dataDict[[NSString stringWithFormat:@"%d",i]]];
            [dataInfoArray addObject:dateInfo];
        }
    }
    
    for(NSInteger i=0;i<dataInfoArray.count;i++)
    {
        if(i%2==0)
        {
            UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, i/2*(120)+90, 320, 29)];
            imageView.image = [UIImage imageNamed:@"bar.png"];
            [self.productContainerView addSubview:imageView];
        }
        
        BufferCategoryView* buffer = [BufferCategoryView viewFromXib];
        buffer.dataInfo = dataInfoArray[i];
        buffer.originY = i/2 * (120) + 10;
        buffer.originX = i%2 * (buffer.sizeW +6) + 6;
        [self.productContainerView addSubview:buffer];
        [buffer renderView];
    }
    
    self.productContainerView.contentSize = CGSizeMake(0, MAX(self.view.sizeH, 3/2*120+10));
    
    [dataInfoArray removeAllObjects];
    dataInfoArray = nil;
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
        self.productContainerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) stockViewClose
{
    if (stock)
    {
        [self clearScrollviewData];
        [self prepareProductContainerView];
        
        [UIView transitionWithView:stock.view duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            stock.view.originX = self.view.sizeW;
        } completion:^(BOOL finished) {
            self.productContainerView.alpha = 1.0f;
            [stock.view removeFromSuperview];
            stock = nil;
        }];
    }
}

- (void)clearScrollviewData
{
    for(UIView *view in self.productContainerView.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
