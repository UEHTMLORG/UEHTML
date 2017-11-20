//
//  ATQModifyZhanghaoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQModifyZhanghaoViewController.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQModifyZhanghaoViewController ()<modifyPasszhanghuDelegate>{
    NSTimer *mTimer;
    int time;
}
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *haomaLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@end

@implementation ATQModifyZhanghaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户安全";
    self.phoneText.text = self.passStr;
    self.codeBtn.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
    self.codeBtn.layer.borderWidth = 1;
    self.codeBtn.layer.cornerRadius = 4;
    self.codeBtn.layer.masksToBounds = YES;

}
- (IBAction)codeClick:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"phone"] = self.phoneText.text;
    params[@"code_type"] = @"change";
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
- (IBAction)saveClick:(id)sender {
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"userphone"] = self.phoneText.text;
    params[@"check_code"] = self.codeText.text;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/change_phone",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----change_phone=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            NSString *user_id = responseObject[@"data"][@"user_id"];
            NSString *user_token = responseObject[@"data"][@"user_token"];
            [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:USER_ID_AOTU_ZL];
            [[NSUserDefaults standardUserDefaults] setObject:user_token forKey:USER_TOEKN_AOTU_ZL];
            if ([self.delegate respondsToSelector:@selector(passzhanghuValue:)]) {
                [self.delegate passzhanghuValue:self.phoneText.text];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"登录失败：%@",error);
    }];
    
    
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
