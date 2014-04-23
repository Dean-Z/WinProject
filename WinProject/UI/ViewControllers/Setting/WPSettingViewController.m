//
//  WPSettingViewController.m
//  WinProject
//
//  Created by Dean on 14-4-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSettingViewController.h"

@interface WPSettingViewController ()

@end

@implementation WPSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    [self.scrollViewContainer setContentSize:CGSizeMake(0, self.view.sizeH)];
    
    [self makeCornerRadiusAtView:self.cell1Container];
    [self makeCornerRadiusAtView:self.cell2Container];
    [self makeCornerRadiusAtView:self.cell3Container];
}

- (void) makeCornerRadiusAtView:(UIView*)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 3.0f;
}

- (IBAction)openWp:(id)sender
{
    
}

- (IBAction)individuation:(id)sender
{
    
}

- (IBAction)resetPassword:(id)sender
{
    
}

- (IBAction)resetName:(id)sender
{
    
}

- (IBAction)callServe:(id)sender
{
    
}

- (IBAction)checkUpdate:(id)sender
{
    
}

- (IBAction)aboutUs:(id)sender
{
    
}

- (IBAction)callForIAd:(id)sender
{
    
}

- (IBAction)logout:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
