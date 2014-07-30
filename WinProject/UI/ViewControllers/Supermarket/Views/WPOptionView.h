//
//  WPOptionView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-14.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPOptionInfo.h"

@protocol WPOptionViewDelegate;

@interface WPOptionView : WPBaseView

@property(nonatomic,strong) NSMutableArray* options;
@property(nonatomic,strong) NSMutableArray* tagImageViews;
@property(nonatomic,strong) IBOutlet UIScrollView *optionsContainer;
@property(nonatomic,strong) WPOptionInfo* selectedOptionsinfo;
@property(nonatomic,assign) id<WPOptionViewDelegate> delegate;

@end


@protocol WPOptionViewDelegate <NSObject>

- (void)optionViewDidSelected:(WPOptionInfo*)info optionView:(WPOptionView*)optionView;

@end