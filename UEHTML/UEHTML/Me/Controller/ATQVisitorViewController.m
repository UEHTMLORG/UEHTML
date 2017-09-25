//
//  ATQVisitorViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQVisitorViewController.h"
#import "YAScrollSegmentControl.h"
#import "UIColor+LhkhColor.h"
@interface ATQVisitorViewController (){
    YAScrollSegmentControl *titleView;
}

@end

@implementation ATQVisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    titleView = [[YAScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tintColor = [UIColor clearColor];
    titleView.buttons = @[@"来访者",@"我看过的人"];
    [titleView setTitleColor:[UIColor colorWithHexString:@"FFE010"] forState:UIControlStateSelected];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = titleView;
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
