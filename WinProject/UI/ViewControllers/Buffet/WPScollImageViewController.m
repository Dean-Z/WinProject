//
//  WPScollImageViewController.m
//  WinProject
//
//  Created by Dean-Z on 14-6-27.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPScollImageViewController.h"
#import "UIImageView+WebCache.h"

@interface WPScollImageViewController ()

@end

@implementation WPScollImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainScrollView.bouncesZoom = YES;
    self.mainScrollView.maximumZoomScale = 2.0;
    self.mainScrollView.minimumZoomScale = 1.0f;
    
    [self.mainImageView setImageWithURL:[NSURL URLWithString:self.dataInfo.url] placeholderImage:[UIImage imageNamed:@"icon-qProduct-loading.png"]];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mainImageView;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (IBAction)back:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
