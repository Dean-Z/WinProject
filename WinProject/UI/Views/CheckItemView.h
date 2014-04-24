//
//  CheckItemView.h
//  WinProject
//
//  Created by Dean on 14-4-24.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol CheckItemViewDelegate;

@interface CheckItemView : WPBaseView
{
    BOOL isClicked;
}

@property(nonatomic,assign) id<CheckItemViewDelegate> delegate;
@property(nonatomic,weak) IBOutlet UIImageView* selectedlImage;

@end


@protocol CheckItemViewDelegate <NSObject>

- (void)CheckItemViewisClicked:(BOOL)click;

@end