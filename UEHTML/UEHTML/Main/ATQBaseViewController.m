//
//  ATQBaseViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "ATQBaseNavigationViewController.h"
#import "AppDelegate.h"

@interface ATQBaseViewController ()

@end

@implementation ATQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)transformView:(UIViewController *)Vc{
    
    ATQBaseNavigationViewController *BaseNavigationViewController = [[ATQBaseNavigationViewController  alloc] initWithRootViewController:Vc];
    UIViewController *rootViewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    [rootViewController addChildViewController:BaseNavigationViewController];
    [rootViewController.view addSubview:BaseNavigationViewController.view];
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
