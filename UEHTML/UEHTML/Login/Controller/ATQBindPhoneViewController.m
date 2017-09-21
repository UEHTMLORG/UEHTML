//
//  ATQBindPhoneViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBindPhoneViewController.h"
#import "UIColor+LhkhColor.h"
#import "ATQRegisterViewController.h"
#import "AppDelegate.h"
@interface ATQBindPhoneViewController (){
    NSTimer *mTimer;
    int time;
}

@end

@implementation ATQBindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"关联手机号";
    UIBarButtonItem *right = [[UIBarButtonItem alloc ]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(RegisterClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 4.f;
    self.img1.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius = 25.f;
    self.img2.layer.masksToBounds = YES;
    self.img2.layer.cornerRadius = 25.f;
    self.img3.layer.masksToBounds = YES;
    self.img3.layer.cornerRadius = 25.f;
    self.codeLab.layer.cornerRadius = 4.f;
    self.codeLab.layer.masksToBounds = YES;
    self.codeLab.layer.borderColor = [UIColor colorWithHexString:UIToneTextColorStr].CGColor;
    self.codeLab.layer.borderWidth = 1.f;
}

//注册
- (void)RegisterClick:(id)sender {
    NSLog(@"RegisterClick");
    ATQRegisterViewController *vc = [[ATQRegisterViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

//登录
- (IBAction)loginClick:(id)sender {
    [(AppDelegate *)[UIApplication sharedApplication].delegate openTabHomeCtrl];
}

//获取验证码
- (IBAction)getCodeClick:(id)sender {
    [self startTimer];
}


- (IBAction)sina:(id)sender {
}
- (IBAction)qq:(id)sender {
}
- (IBAction)wechat:(id)sender {
}



// 开始定时器
- (void) startTimer{
    // 定义一个NSTimer
    time = 60;
    mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(doTimer:)  userInfo:nil
                                             repeats:YES];
}

// 定时器执行的方法
- (void)doTimer:(NSTimer *)timer{
    time--;
    if (time > 0) {
        NSString *title = [NSString stringWithFormat:@"%ds重新获取",time];
        self.codeLab.text = title;
        self.codeLab.textAlignment = NSTextAlignmentCenter;
        [self.codeBtn setEnabled:false];
    }else{
        [self.codeBtn setEnabled:true];
        self.codeLab.text = @"重新获取";
        [self stopTimer];
    }
}

// 停止定时器
- (void) stopTimer{
    if (mTimer != nil){
        [mTimer invalidate];
    }
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
