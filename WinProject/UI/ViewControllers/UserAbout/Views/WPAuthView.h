//
//  WPAuthView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPAuthViewDelegate;

@interface WPAuthView : WPBaseView
{
    NSInteger count;
}
@property(nonatomic,weak) IBOutlet UILabel* phoneNumber;
@property(nonatomic,weak) IBOutlet UILabel* downcountLabel;
@property(nonatomic,weak) IBOutlet UITextField* authCodeTextField;
@property(nonatomic,strong) NSString* phoneNumebrString;

@property(nonatomic,assign) id<WPAuthViewDelegate> delegate;

@end


@protocol WPAuthViewDelegate <NSObject>

- (void) authBack;
- (void) authSucceed;

@end