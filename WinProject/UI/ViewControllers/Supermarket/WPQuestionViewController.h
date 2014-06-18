//
//  WPQuestionViewController.h
//  WinProject
//
//  Created by Dean-Z on 14-6-13.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "BaseXibViewController.h"
#import "WPOptionView.h"

@protocol WPQuestionViewControllerDelegate;

@interface WPQuestionViewController : BaseXibViewController<WPOptionViewDelegate>

@property(nonatomic,strong) NSDictionary* requestResult;
@property(nonatomic,strong) WPOptionView *optionView;

@property(nonatomic,strong) NSMutableArray* optionResultArray;
@property(nonatomic,strong) NSMutableDictionary* optionData;
@property(nonatomic,strong) NSString* questionId;

@property(nonatomic,assign) id<WPQuestionViewControllerDelegate> delegate;

@end

@protocol WPQuestionViewControllerDelegate <NSObject>

- (void) finishQuestion:(NSString*)questionId;

@end