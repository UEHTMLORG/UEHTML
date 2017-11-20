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
#import "UIColor+LhkhColor.h"
#import "ATQBindPhoneViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQFaceRZViewController.h"
@interface ATQLoginViewController (){
    NSTimer *mTimer;
    int time;
}

@end

@implementation ATQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    UIBarButtonItem *right = [[UIBarButtonItem alloc ]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(RegisterClick:)];
    self.navigationItem.rightBarButtonItem = right;
    [self buildView];
}

-(void)buildView{
    
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

//获取验证码
- (IBAction)getCode:(id)sender {
    NSLog(@"getCode");
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"phone"] = self.userText.text;
    params[@"code_type"] = @"login";
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [ZLSecondAFNetworking getNowTime];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [ZLSecondAFNetworking getMD5fromString:signStr];
    NSString *sign2 = [ZLSecondAFNetworking getMD5fromString:sign1];
    NSString *sign = [ZLSecondAFNetworking getMD5fromString:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/sms_check_code",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----sms_check_code=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            [self startTimer];
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"登录失败：%@",error);
    }];

}

//登录
- (IBAction)login:(id)sender {
    NSLog(@"login");

   //[(AppDelegate *)[UIApplication sharedApplication].delegate openTabHomeCtrl];

    if (self.userText.text.length > 0 && self.userText.text != nil && ![self.userText isKindOfClass:[NSNull  class]] && ![self.userText.text isEqualToString:@""] && !(self.userText.text.length > 11)) {
        
        NSMutableDictionary *params = [NSMutableDictionary  dictionary];
        params[@"username"] = self.userText.text;
        params[@"check_code"] = @"111111";
        params[@"apptype"] = @"ios";
        params[@"appversion"] = APPVERSION_AOTU_ZL;
        NSString *random_str = [ZLSecondAFNetworking getNowTime];
        params[@"random_str"] = random_str;
        NSString *app_token = APP_TOKEN;
        NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
        NSString *sign1 = [ZLSecondAFNetworking getMD5fromString:signStr];
        NSString *sign2 = [ZLSecondAFNetworking getMD5fromString:sign1];
        NSString *sign = [ZLSecondAFNetworking getMD5fromString:sign2];
        params[@"sign"] = sign;
        NSString *url = [NSString stringWithFormat:@"%@/api/user/login",ATQBaseUrl];

        [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
            NSLog(@"-----Login=%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                NSString *user_id = responseObject[@"data"][@"user_id"];
                NSString *user_token = responseObject[@"data"][@"user_token"];
                NSString *message_token = responseObject[@"data"][@"message_token"];
                [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:USER_ID_AOTU_ZL];
                [[NSUserDefaults standardUserDefaults] setObject:user_token forKey:USER_TOEKN_AOTU_ZL];
                [[NSUserDefaults standardUserDefaults] setObject:message_token forKey:MESSAGE_TOKEN_AOTU_ZL];
                /** 登录融云 */
                [[ZLRongYunManager shareInstance] rongYunLogin];
                [(AppDelegate *)[UIApplication sharedApplication].delegate openTabHomeCtrl];
            }else{
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
            }

        } failure:^(NSError *error) {
            NSLog(@"登录失败：%@",error);
        }];


    }else{
        [MBProgressHUD show:@"请正确输入手机号码" view:self.view];
        return;
    }
    
}

//微博登录
- (IBAction)sina:(id)sender {
    NSLog(@"sina");
    ATQBindPhoneViewController *vc = [[ATQBindPhoneViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//qq登录
- (IBAction)qq:(id)sender {
    NSLog(@"qq");
    ATQBindPhoneViewController *vc = [[ATQBindPhoneViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//微信登录
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
