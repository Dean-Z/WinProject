//
//  XibViewController.h
//  shopCart
//
//  Created by Dean on 13-10-13.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BaseXibViewController : UIViewController

@property(nonatomic,strong) AppDelegate*    app;

@property(nonatomic,weak) IBOutlet UIView* navigationContiner;

-(id)viewControllerFromXib;

-(void)clearViewController;
-(void)clearView:(UIView*)view;

@end

