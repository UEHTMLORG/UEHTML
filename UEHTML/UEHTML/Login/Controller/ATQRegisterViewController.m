//
//  ATQRegisterViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRegisterViewController.h"

@interface ATQRegisterViewController ()
{
    NSTimer *mTimer;
    int time;
}
@end

@implementation ATQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildView];
}
-(void)buildView{
    self.userView.layer.masksToBounds = YES;
    self.userView.layer.cornerRadius = 4.f;
    self.userView.layer.borderWidth = 1.f;
    self.userView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.verCodeView.layer.masksToBounds = YES;
    self.verCodeView.layer.cornerRadius = 4.f;
    self.verCodeView.layer.borderWidth = 1.f;
    self.verCodeView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.pwdView.layer.masksToBounds = YES;
    self.pwdView.layer.cornerRadius = 4.f;
    self.pwdView.layer.borderWidth = 1.f;
    self.pwdView.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.cornerRadius = 4.f;
    
    
    self.img1.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius = 25.f;
    self.img2.layer.masksToBounds = YES;
    self.img2.layer.cornerRadius = 25.f;
    self.img3.layer.masksToBounds = YES;
    self.img3.layer.cornerRadius = 25.f;
    
    
}
//返回
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//获取验证码
- (IBAction)getCode:(id)sender {
    NSLog(@"getCode");
    [self startTimer];
}
//获取语音验证码
- (IBAction)getAudio:(id)sender {
    NSLog(@"getAudio");
    
}
//隐藏密码
- (IBAction)hide:(id)sender {
    NSLog(@"hide");
    
}
//注册
- (IBAction)registerClick:(id)sender {
    NSLog(@"registerClick");
}
//微博
- (IBAction)sina:(id)sender {
    NSLog(@"sina");
}
//qq
- (IBAction)qq:(id)sender {
    NSLog(@"qq");
}
//微信
- (IBAction)wechat:(id)sender {
    NSLog(@"wechat");
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
