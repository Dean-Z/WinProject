//
//  WPConversionView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPConversionViewDelegate;

@interface WPConversionView : WPBaseView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView* tableview;
@property (nonatomic,assign) id<WPConversionViewDelegate> delegate;

@end


@protocol WPConversionViewDelegate <NSObject>

- (void)conversionCancel;
- (void)conversionSelectAtIndex:(NSInteger)index;

@end