//
//  WPShareManager.m
//  WinProject
//
//  Created by Dean-Z on 14-5-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPShareManager.h"

@implementation WPShareManager

-(void)shareWithSina:(UIImage*)image message:(NSString*)message
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShareWithSina:image message:message]];
    
    [WeiboSDK sendRequest:request];
}

- (WBMessageObject *)messageToShareWithSina:(UIImage*)image message:(NSString*)messages
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = @"测试通过WeiboSDK发送文字到微博!";
    
    WBImageObject *aImage = [WBImageObject object];
    aImage.imageData = UIImagePNGRepresentation(image);
    message.imageObject = aImage;
    
    return message;
}


@end
