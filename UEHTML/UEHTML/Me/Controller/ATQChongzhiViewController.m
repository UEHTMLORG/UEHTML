//
//  ATQChongzhiViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQChongzhiViewController.h"

@interface ATQChongzhiViewController ()<UIScrollViewDelegate>

@end

@implementation ATQChongzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户充值";
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 1000);
    
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
