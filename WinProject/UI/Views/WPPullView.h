//
//  WPPullView.h
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPPullView : WPBaseView
{
    BOOL isPull;
}

@property(nonatomic,weak) IBOutlet UILabel* firstCellLabel;
@property(nonatomic,weak) IBOutlet UIImageView* pullViewNormal;
@property(nonatomic,weak) IBOutlet UIImageView* pullViewSelected;
@property(nonatomic,strong) NSMutableArray* exchangeArray;

@end
