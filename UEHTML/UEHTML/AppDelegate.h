//
//  AppDelegate.h
//  UEHTML
//
//  Created by LHKH on 2017/8/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATQBaseTabBarViewController.h"
#import "ATQBaseNavigationViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  ATQBaseTabBarViewController*BaseTabBarController;
@property (strong, nonatomic) ATQBaseNavigationViewController *BaseNavigationViewController;
-(void)openLoginCtrl;
-(void)openTabHomeCtrl;
@end

