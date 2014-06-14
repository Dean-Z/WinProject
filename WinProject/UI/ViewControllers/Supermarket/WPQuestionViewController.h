//
//  WPQuestionViewController.h
//  WinProject
//
//  Created by Dean-Z on 14-6-13.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPOptionView.h"

@interface WPQuestionViewController : BaseXibViewController<WPOptionViewDelegate>

@property(nonatomic,strong) NSDictionary* requestResult;
@property(nonatomic,strong) WPOptionView *optionView;

@property(nonatomic,strong) NSMutableArray* optionResultArray;
@property(nonatomic,strong) NSMutableDictionary* optionData;

@end
