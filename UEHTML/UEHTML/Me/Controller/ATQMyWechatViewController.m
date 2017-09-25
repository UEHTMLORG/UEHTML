//
//  ATQMyWechatViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyWechatViewController.h"
#import "YAScrollSegmentControl.h"
#import "UIColor+LhkhColor.h"
@interface ATQMyWechatViewController (){
    YAScrollSegmentControl *titleView;
}

@end

@implementation ATQMyWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    titleView = [[YAScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
//    titleView.backgroundColor = [UIColor clearColor];
//    titleView.tintColor = [UIColor clearColor];
//    titleView.buttons = @[@"我的微信号",@"谁查看我的微信",@"已查看的微信"];
//    [titleView setFont:[UIFont systemFontOfSize:12]];
//    [titleView setTitleColor:[UIColor colorWithHexString:@"FFE010"] forState:UIControlStateSelected];
//    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.navigationItem.titleView = titleView;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = view;
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
