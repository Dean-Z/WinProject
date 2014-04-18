//
//  UIView+Utils.h
//  Monogram
//
//  Created by Cheney Yan on 1/29/12.
//  Copyright (c) 2012 Fara Inc. All rights reserved.
//

@interface UIView (Utils)

@property (nonatomic,assign) CGPoint   origin;
@property (nonatomic,assign) CGFloat   originX;
@property (nonatomic,assign) CGFloat   originY;
@property (nonatomic,assign) CGSize    size;
@property (nonatomic,assign) CGFloat   sizeW;
@property (nonatomic,assign) CGFloat   sizeH;

- (UIImage *)screenshot;

- (void)cleanupGestures;


@end
