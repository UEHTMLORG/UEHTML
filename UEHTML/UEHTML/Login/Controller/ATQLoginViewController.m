//
//  ATQLoginViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQLoginViewController.h"
#import "AppDelegate.h"
#import "ATQRegisterViewController.h"

@interface ATQLoginViewController ()

@end

@implementation ATQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildView];
}

-(void)buildView{
    self.userView.layer.masksToBounds = YES;
    self.userView.layer.cornerRadius = 4.f;
    self.userView.layer.borderWidth = 1.f;
    self.userView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.pwdView.layer.masksToBounds = YES;
    self.pwdView.layer.cornerRadius = 4.f;
    self.pwdView.layer.borderWidth = 1.f;
    self.pwdView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 4.f;
    
    
    self.img1.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius = 25.f;
    self.img2.layer.masksToBounds = YES;
    self.img2.layer.cornerRadius = 25.f;
    self.img3.layer.masksToBounds = YES;
    self.img3.layer.cornerRadius = 25.f;
    
    
}
//返回
- (IBAction)back:(id)sender {
    NSLog(@"back");
    [(AppDelegate *)[UIApplication sharedApplication].delegate openTabHomeCtrl];
}
//注册
- (IBAction)RegisterClick:(id)sender {
    NSLog(@"RegisterClick");
    ATQRegisterViewController *vc = [[ATQRegisterViewController  alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
//隐藏密码
- (IBAction)hide:(id)sender {
    NSLog(@"hide");
}
//忘记密码
- (IBAction)forgetPwd:(id)sender {
    NSLog(@"forgetPwd");
}
//登录
- (IBAction)login:(id)sender {
    NSLog(@"login");
}
//微博登录
- (IBAction)sina:(id)sender {
    NSLog(@"sina");
}
//qq登录
- (IBAction)qq:(id)sender {
    NSLog(@"qq");
}
//微信登录
- (IBAction)wechat:(id)sender {
    NSLog(@"wechat");
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
