//
//  AppDelegate.m
//  UEHTML
//
//  Created by LHKH on 2017/8/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "AppDelegate.h"
#import "ATQLoginViewController.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self openLoginCtrl];
    
//    [self openTabHomeCtrl];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    
    /**
     *==========ZL注释start===========
     *1.集成融云
     *
     *2.融云属性设置
     *3.
     *4.测试用户userID ：123456 测试token  OHlSp+amcIt58AxlcDfLzVC0fO+o1gwgo3K8JJIiWcl47Aw0JaPFlBwIwzmForSmn9Lit6Rj5XHXLm7n5dLStQ==
     ===========ZL注释end==========*/
    NSString * ceToken = @"OHlSp+amcIt58AxlcDfLzVC0fO+o1gwgo3K8JJIiWcl47Aw0JaPFlBwIwzmForSmn9Lit6Rj5XHXLm7n5dLStQ==";
    [[RCIM sharedRCIM] initWithAppKey:RONGYUN_APPKEY];
    [[RCIM sharedRCIM] setEnablePersistentUserInfoCache:YES];//用户信息保存到本地缓存中
    //设置用户信息源和群组信息源
    [RCIM sharedRCIM].userInfoDataSource = RCDDataSource;
    [RCIM sharedRCIM].groupInfoDataSource = RCDDataSource;
    
    //设置接收消息代理
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    //    [RCIM sharedRCIM].globalMessagePortraitSize = CGSizeMake(46, 46);
    //开启输入状态监听
    [RCIM sharedRCIM].enableTypingStatus = YES;
    
    //开启发送已读回执
    [RCIM sharedRCIM].enabledReadReceiptConversationTypeList = @[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)];
    
    //开启多端未读状态同步
    [RCIM sharedRCIM].enableSyncReadStatus = YES;
    
    //设置显示未注册的消息
    //如：新版本增加了某种自定义消息，但是老版本不能识别，开发者可以在旧版本中预先自定义这种未识别的消息的显示
    [RCIM sharedRCIM].showUnkownMessage = YES;
    [RCIM sharedRCIM].showUnkownMessageNotificaiton = YES;
    
    //群成员数据源
    [RCIM sharedRCIM].groupMemberDataSource = RCDDataSource;
    
    //开启消息@功能（只支持群聊和讨论组, App需要实现群成员数据源groupMemberDataSource）
    [RCIM sharedRCIM].enableMessageMentioned = YES;
    
    //开启消息撤回功能
    [RCIM sharedRCIM].enableMessageRecall = YES;
    
    
    //  设置头像为圆形
    //  [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    //  [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    //   设置优先使用WebView打开URL
    //  [RCIM sharedRCIM].embeddedWebViewPreferred = YES;
    
    //  设置通话视频分辨率
    //  [[RCCallClient sharedRCCallClient] setVideoProfile:RC_VIDEO_PROFILE_480P];
    
    //设置Log级别，开发阶段打印详细log
    [RCIMClient sharedRCIMClient].logLevel = RC_Log_Level_Info;
    
    
    [[RCIM sharedRCIM] connectWithToken:ceToken    success:^(NSString *userId) {
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
    return YES;
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
    if ([userId isEqualToString:@"test02"]) {
        RCUserInfo *userInfo = [[RCUserInfo alloc]init];
        userInfo.userId = userId;
        userInfo.name = @"测试2用户名";
        userInfo.portraitUri = @"https://gss1.bdstatic.com/9vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=3b03c837572c11dfcadcb771024e09b5/ae51f3deb48f8c54cd34cafb3a292df5e1fe7f7a.jpg";
        return completion(userInfo);
    }
    return completion(nil);
}

-(void)openLoginCtrl
{
    ATQLoginViewController *vc = [[ATQLoginViewController alloc]init];
    self.BaseNavigationViewController = [[ATQBaseNavigationViewController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = self.BaseNavigationViewController;
    [self.window addSubview:self.BaseNavigationViewController.view];
    [self.window makeKeyAndVisible];
}

- (void)openTabHomeCtrl
{
    self.BaseTabBarController = [ATQBaseTabBarViewController new];
    self.window.rootViewController = self.BaseTabBarController;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
