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
     *2.<#注释描述#>
     *3.<#注释描述#>
     *4.测试用户userID ：123456 测试token  OHlSp+amcIt58AxlcDfLzVC0fO+o1gwgo3K8JJIiWcl47Aw0JaPFlBwIwzmForSmn9Lit6Rj5XHXLm7n5dLStQ==
     ===========ZL注释end==========*/
    NSString * ceToken = @"OHlSp+amcIt58AxlcDfLzVC0fO+o1gwgo3K8JJIiWcl47Aw0JaPFlBwIwzmForSmn9Lit6Rj5XHXLm7n5dLStQ==";
    [[RCIM sharedRCIM] initWithAppKey:RONGYUN_APPKEY];
    
    [[RCIM sharedRCIM] connectWithToken:ceToken     success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
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
