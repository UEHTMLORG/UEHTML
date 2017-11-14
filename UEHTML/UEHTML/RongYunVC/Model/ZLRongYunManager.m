//
//  ZLRongYunManager.m
//  UEHTML
//
//  Created by apple on 2017/11/14.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLRongYunManager.h"

@implementation ZLRongYunManager

+ (ZLRongYunManager *)shareInstance{
    
    static ZLRongYunManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)rongYunLogin{
    [[RCIM sharedRCIM] connectWithToken:[kUserDefaults objectForKey:MESSAGE_TOKEN_AOTU_ZL]    success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [[RCIM sharedRCIM] setUserInfoDataSource:self];
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}


@end
