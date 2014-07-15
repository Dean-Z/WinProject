//
//  XibViewController.m
//  shopCart
//
//  Created by Dean on 13-10-13.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"

@interface BaseXibViewController ()
{
    
}
@end

@implementation BaseXibViewController

-(id)viewControllerFromXib
{
    return [self initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (IS_IPHONE())
    {
        NSString *originNibName = nibNameOrNil;
        NSString *suffixName    = IS_IPHONE_5 ? @"_iPhone5" : @"_iPhone";
        
        if ([NSString isNilOrEmpty:nibNameOrNil])
        {
            nibNameOrNil = [NSString stringWithFormat:@"%@%@", [self class], suffixName];
        }
        else
        {
            nibNameOrNil = [nibNameOrNil stringByAppendingString:suffixName];
        }
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:nibNameOrNil ofType:@"nib"];
        
        if ([NSString isNilOrEmpty:nibPath])
        {
            nibNameOrNil = originNibName;
        }
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        [self viewControllerRender];
    }
    
    return self;
}

-(void)viewControllerRender
{
    self.app  = [AppDelegate shareAppDelegate];
    [self.navigationController setNavigationBarHidden:YES];
    
//    [[UIApplication sharedApplication]setStatusBarHidden:YES];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}


-(void)clearViewController
{
    self.app = nil;
    [self.navigationContiner removeFromSuperview];
    self.navigationContiner = nil;
}

-(void)clearView:(UIView*)view
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
