//
//  WPAlipayView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPConversionInfo.h"
#import "AlipayView.h"

@protocol WPAlipayViewDelegate;
@interface WPAlipayView : WPBaseView<UITableViewDataSource,UITableViewDelegate,AlipayViewDelegate>
{
    NSMutableArray* _conversionArray;
    AlipayView* alipayView;
    UIScrollView* alipayViewContainer;
    BOOL alipayShowing;
}

@property (nonatomic,weak) IBOutlet UITableView* tableview;
@property (nonatomic,assign) id<WPAlipayViewDelegate> delegate;

@end

@protocol WPAlipayViewDelegate <NSObject>

- (void)alipayCancel;

@end
