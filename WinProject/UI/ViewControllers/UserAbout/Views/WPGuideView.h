//
//  WPGuideView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-19.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPGuideView : WPBaseView<UIScrollViewDelegate>

@property(nonatomic,weak) IBOutlet UIScrollView* scrollview;

@end
