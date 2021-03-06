//
//  WPBuffetViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBuffetViewController.h"
#import "BufferCategoryView.h"
#import "WPScollImageViewController.h"

@interface WPBuffetViewController ()<BufferCategoryViewDelegate>
{
    WPStockViewController* stock;
}

@property (nonatomic,strong) NSMutableArray *buffersArray;

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
    
   self.buffersArray = [@[] mutableCopy];
    
    [self prepareProductContainerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.buffersArray.count > 0)
    {
        for (BufferCategoryView* buffer in self.buffersArray)
        {
            [buffer loopBrand];
        }
    }
}

- (void)prepareProductContainerView
{
    [self.buffersArray removeAllObjects];
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    NSString* dataString = [user objectForKey:CORVER_DATA];
    
    if([NSString isNilOrEmpty:dataString]){
        self.noDataImageView.hidden = NO;
        return;
    }
    
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
        buffer.delegate = self;
        buffer.dataInfo = dataInfoArray[i];
        buffer.originY = i/2 * (120) + 10;
        buffer.originX = i%2 * (buffer.sizeW +6) + 6;
        [self.productContainerView addSubview:buffer];
        [self.buffersArray addObject:buffer];
        [buffer renderView];
    }
    
    if (dataInfoArray.count == 0)
    {
        self.noDataImageView.hidden = NO;
    }
    else
    {
        self.noDataImageView.hidden = YES;
    }
    
    self.productContainerView.contentSize = CGSizeMake(0, MAX(self.view.sizeH-44, (dataInfoArray.count/2+1)*120));
    
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
        if (view == self.noDataImageView)
        {
            continue;
        }
        [view removeFromSuperview];
    }
}

- (void)bufferCategoryViewTouched:(WPCBaseDateInfo *)dataInfo
{
    WPScollImageViewController* scroll = [[WPScollImageViewController alloc]viewControllerFromXib];
    scroll.dataInfo = dataInfo;
    [self.app.aTabBarController.navigationController pushViewController:scroll animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
