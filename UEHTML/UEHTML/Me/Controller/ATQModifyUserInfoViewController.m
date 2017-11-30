//
//  ATQModifyUserInfoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQModifyUserInfoViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQModifyUserInfoViewController ()<modifyPassValueDelegate>
@property (weak, nonatomic) IBOutlet UITextField *passValueText;
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topH;

@end

@implementation ATQModifyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.natitle;
    self.passValueText.text = _passStr;
    if ([self.natitle isEqualToString:@"我的昵称"]) {
        self.disLab.text = @"昵称将是您在美柚凹凸圈里的身份标识额，请设置您独一无二的昵称:";
    }else{
        self.disLab.hidden = YES;
        self.topH.constant = 30;
    }
    
    
}
- (IBAction)saveClick:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    if ([self.natitle isEqualToString:@"我的昵称"]) {
        params[@"param_name"] = @"nick_name";
        params[@"param_value"] = self.passValueText.text;
    }else if ([self.natitle isEqualToString:@"身高"]){
        params[@"param_name"] = @"height";
        params[@"param_value"] = self.passValueText.text;
    }else if ([self.natitle isEqualToString:@"体重"]){
        params[@"param_name"] = @"weight";
        params[@"param_value"] = self.passValueText.text;
    }else if ([self.natitle isEqualToString:@"年龄"]){
        params[@"param_name"] = @"age";
        params[@"param_value"] = self.passValueText.text;
    }
    
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/profile_modify",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----profile_modify=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                if ([self.delegate respondsToSelector:@selector(passmodifyValue:type:)]) {
                    [self.delegate passmodifyValue:self.passValueText.text type:_natitle];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
