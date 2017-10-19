//
//  ATQRegisterViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRegisterViewController.h"
#import "ATQLoginViewController.h"
#import "ATQFaceRZViewController.h"
#import "UIColor+LhkhColor.h"
#import "ATQBindPhoneViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQRegisterViewController ()
{
    NSTimer *mTimer;
    int time;
}
@end

@implementation ATQRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册凹凸圈";
    UIBarButtonItem *right = [[UIBarButtonItem alloc ]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = right;
    if (ScreenWidth <= 320) {
        self.TextTop.constant = 10;
        self.registerTop.constant = 10;
        self.bottomH.constant = 120;
    }else{
        self.TextTop.constant = 20;
        self.registerTop.constant = 30;
        self.bottomH.constant = 150;
    }
    
    [self buildView];
}
-(void)buildView{
    
    self.codeLab.layer.masksToBounds = YES;
    self.codeLab.layer.cornerRadius = 4.f;
    self.codeLab.layer.borderWidth = 1.f;
    self.codeLab.layer.borderColor = [UIColor colorWithHexString:UIToneTextColorStr].CGColor;
    
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
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)login{
    ATQLoginViewController *vc = [[ATQLoginViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//获取验证码
- (IBAction)getCode:(id)sender {
    NSLog(@"getCode");
    [self startTimer];
}
////获取语音验证码
//- (IBAction)getAudio:(id)sender {
//    NSLog(@"getAudio");
//    
//}

//注册
- (IBAction)registerClick:(id)sender {
    NSLog(@"registerClick");
    if (self.userPhone.text.length > 0 && self.userPhone.text != nil && ![self.userPhone isKindOfClass:[NSNull  class]] && ![self.userPhone.text isEqualToString:@""] && !(self.userPhone.text.length > 11)) {
        
        NSMutableDictionary *params = [NSMutableDictionary  dictionary];
        params[@"username"] = self.userPhone.text;
        params[@"check_code"] = @"111111";
        params[@"apptype"] = @"ios";
        params[@"appversion"] = @"1.0.0";
        NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
        params[@"random_str"] = random_str;
        NSString *app_token = APP_TOKEN;
        NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
        NSString *sign1 = [LhkhHttpsManager md5:signStr];
        NSString *sign2 = [LhkhHttpsManager md5:sign1];
        NSString *sign = [LhkhHttpsManager md5:sign2];
        params[@"sign"] = sign;
        NSString *url = [NSString stringWithFormat:@"%@/api/user/register/step1",ATQBaseUrl];
        [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
            NSLog(@"-----register/step1=%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                NSString *user_id = responseObject[@"data"][@"user_id"];
                NSString *user_token = responseObject[@"data"][@"user_token"];
                [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:USER_ID_AOTU_ZL];
                [[NSUserDefaults standardUserDefaults] setObject:user_token forKey:USER_TOEKN_AOTU_ZL];
                
                ATQFaceRZViewController *vc = [[ATQFaceRZViewController alloc] init];
                [self.navigationController pushViewController:vc animated:NO];
                
            }else{
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
            }
            
        } failure:^(NSError *error) {
            NSString *str = [NSString stringWithFormat:@"%@",error];
            [MBProgressHUD show:str view:self.view];
        }];
        
    }else{
        [MBProgressHUD show:@"请正确输入手机号码" view:self.view];
        return;
    }
    
}
//微博
- (IBAction)sina:(id)sender {
    NSLog(@"sina");
    ATQBindPhoneViewController *vc = [[ATQBindPhoneViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//qq
- (IBAction)qq:(id)sender {
    NSLog(@"qq");
    ATQBindPhoneViewController *vc = [[ATQBindPhoneViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//微信
- (IBAction)wechat:(id)sender {
    NSLog(@"wechat");
    ATQBindPhoneViewController *vc = [[ATQBindPhoneViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
