//
//  ATQBaseNavigationViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseNavigationViewController.h"
#import "ATQSearchFriendsViewController.h"
#import "UIImage+LhkhExtension.h"
#import "UIColor+LhkhColor.h"
#import "UIView+LhkhExtension.h"
@interface ATQBaseNavigationViewController ()

@end

@implementation ATQBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView{
    
    [super loadView];
    //背景颜色
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:UIColorStr] size:CGSizeMake(self.navigationBar.width, self.navigationBar.height+20)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //状态栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //title颜色和字体
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],  NSFontAttributeName:[UIFont systemFontOfSize:18]};
    if ([UIDevice currentDevice].systemVersion.floatValue >8.0 ) {
        self.navigationBar.barTintColor = [UIColor whiteColor];
    }
    //系统返回按钮图片设置
//    NSString *imageName = @"back_more";
//    if ([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleDefault) {
//        imageName = @"back_more";
//    }
//    UIImage *image = [UIImage imageNamed:imageName];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width-1, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0)
//                                                         forBarMetrics:UIBarMetricsDefault];

//    self.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_more"];
//    self.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_more"];
//
}

#pragma mark push
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_more"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    }
    for (Class classes in self.rootVcAry) {
        if ([viewController isKindOfClass:classes]) {
            if (self.navigationController.viewControllers.count > 0) {
                viewController.hidesBottomBarWhenPushed = YES;
            } else {
                viewController.hidesBottomBarWhenPushed = NO;
            }
        }else{
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }
    if ([viewController isKindOfClass:[ATQSearchFriendsViewController class]]) {
        [viewController.navigationController.navigationItem setHidesBackButton:YES];
        [viewController.navigationItem setHidesBackButton:YES];
        [viewController.navigationController.navigationBar.backItem setHidesBackButton:YES];
    }else{
        [viewController.navigationController.navigationItem setHidesBackButton:NO];
        [viewController.navigationItem setHidesBackButton:NO];
        [viewController.navigationController.navigationBar.backItem setHidesBackButton:NO];
    }
    [super pushViewController:viewController animated:NO];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}
-(NSMutableArray*)rootVcAry{
    if (!_rootVcAry) {
        _rootVcAry = [NSMutableArray array];
    }
    return _rootVcAry;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
