//
//  ATQYJBuyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQYJBuyViewController.h"

@interface ATQYJBuyViewController ()
{
    NSString *payStr;
}
@property (weak, nonatomic) IBOutlet UILabel *yajinLab;
@property (weak, nonatomic) IBOutlet UIButton *xufeiBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;
@property (weak, nonatomic) IBOutlet UIButton *renzhengBtn;

@end

@implementation ATQYJBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"押金认证";
    payStr = @"wechatPay";
    self.yajinLab.text = [NSString stringWithFormat:@"%@元",_yajinStr];
}
- (IBAction)xufeiClick:(id)sender {
    self.xufeiBtn.selected = !self.xufeiBtn.selected;
}
- (IBAction)wxClick:(id)sender {
    payStr = @"wechatPay";
    self.zfbBtn.selected = NO;
    self.wxBtn.selected = !self.zfbBtn.selected;
}
- (IBAction)zfbClick:(id)sender {
    payStr = @"aliPay";
    self.wxBtn.selected = NO;
    self.zfbBtn.selected = !self.wxBtn.selected;
}
- (IBAction)renzhengClick:(id)sender {
    NSLog(@"%@%@",payStr,self.yajinLab.text);
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
