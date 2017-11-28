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
         [kUserDefaults setObject:userId forKey:RONGYUN_USER_ID];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[[RCIM sharedRCIM] setUserInfoDataSource:self];
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
/**
 *==========ZL注释start===========
 *1.融云  用户信息类 获取用户信息代理方法实现
 *
 *2.返回用户信息  头像 昵称
 *3.
 *4.
 ===========ZL注释end==========*/

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion{
    NSLog(@"在APPdelegate中获取用户信息：%@",userId);
    if ([userId isEqualToString:@"2089"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc]init];
        userInfo.userId = userId;
        userInfo.name = @"测试2用户名";
        userInfo.portraitUri = @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=3b03c837572c11dfcadcb771024e09b5/ae51f3deb48f8c54cd34cafb3a292df5e1fe7f7a.jpg";
        return completion(userInfo);
    }
    return completion(nil);
}

@end
