//
//  WPShareManager.m
//  WinProject
//
//  Created by Dean-Z on 14-5-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPShareManager.h"
#import "WeiboSDK.h"
#import "UMSocial.h"

#define Msg @"动漫壁纸免费下，商家互动赚外快。有看有赚! http://jbp.allgather.net"

@implementation WPShareManager

-(BOOL)shareWithSina:(UIImage*)image message:(NSString*)message
{
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShareWithSina:image message:message]];
    
    if ([WeiboSDK isWeiboAppInstalled])
    {
        [WeiboSDK sendRequest:request];
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)shareSinaWithUM:(UIViewController *)viewController image:(UIImage *)image
{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:Msg image:image location:nil urlResource:nil presentedController:viewController completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        }
    }];
}


- (WBMessageObject *)messageToShareWithSina:(UIImage*)image message:(NSString*)messages
{
    WBMessageObject *message = [WBMessageObject message];
    
    message.text = @"动漫壁纸免费下，商家互动赚外快。有看有赚! http://jbp.allgather.net";

    WBImageObject *aImage = [WBImageObject object];
    aImage.imageData = UIImagePNGRepresentation(image);
    message.imageObject = aImage;
    
    return message;
}


- (void)shareWithTCWeiBo:(UIViewController*)viewController image:(UIImage*)image
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTencentWeibo])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTencentWeibo];
        
        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultDone)
            {
                [[WPAlertView viewFromXib]showWithMessage:@"分享成功"];
            }
            [controller dismissViewControllerAnimated:YES completion:Nil];
        };
        controller.completionHandler = myBlock;
        [controller setInitialText:@"动漫壁纸免费下，商家互动赚外快。有看有赚! http://jbp.allgather.net"];
        [controller addImage:image];
        [viewController presentViewController:controller animated:YES completion:Nil];
    }
    else
    {
        [[WPAlertView viewFromXib] showWithMessage:@"请先在手机设置的腾讯微博里登陆您的微博!"];
    }
}

- (void)shareWithWx:(enum WXScene)scene
{
//    if (![WXApi isWXAppInstalled])
//    {
//        [[WPAlertView viewFromXib]showWithMessage:@"未安装微信！"];
//        return;
//    }
    [WXApi registerApp:WXAPPKey withDescription:@"win 1.0"];
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = @"动漫壁纸免费下，商家互动赚外快。有看有赚! http://jbp.allgather.net";
    req.bText = YES;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

@end
