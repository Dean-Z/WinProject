//
//  BufferProductView.h
//  WinProject
//
//  Created by Dean on 14-4-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "UIImageView+WebCache.h"
#import "WPProductButton.h"

@interface BufferProductView : WPBaseView

@property(nonatomic,weak) IBOutlet UIImageView* productImage;
@property(nonatomic,weak) IBOutlet UILabel*     endTimeLabel;
@property(nonatomic,weak) IBOutlet UILabel*     numberProductLabel;
@property(nonatomic,weak) IBOutlet UIView*      priceBtnContainer;

@end
