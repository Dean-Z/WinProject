//
//  WPConversionProductView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "ConversionAlertView.h"

@protocol WPConversionProductViewDelegate;

@interface WPConversionProductView : WPBaseView<UITableViewDataSource,UITableViewDelegate,ConversionAlertViewDelegate>

@property(nonatomic,weak) IBOutlet UITableView* tableview;
@property(nonatomic,assign) NSInteger page;

@property(nonatomic,assign) id<WPConversionProductViewDelegate> delegate;

@end

@protocol WPConversionProductViewDelegate <NSObject>

- (void)conversionProductCancel;

@end