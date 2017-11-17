//
//  ATQTypePeoDetailViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTypePeoDetailViewController.h"
#import "ATQYajinRZViewController.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
@interface ATQTypePeoDetailViewController ()<UITextViewDelegate>

@end

@implementation ATQTypePeoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下单约TA";
    [self buildTextView];
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"job_id"] = self.jobID;
    params[@"page_index"] = @"1";
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
    NSString *url = [NSString stringWithFormat:@"%@/api/job/place_order/work_about_her",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {

        NSLog(@"-----work_about_her=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                NSDictionary *user_profile = responseObject[@"data"][@"user_profile"];
                [self.userImg sd_setImageWithURL:[NSURL URLWithString:user_profile[@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];
                self.userNameLab.text = user_profile[@"nick_name"];
                self.chengLab.text = user_profile[@"credit_num"];
                self.ageLab.text = user_profile[@"age"];
                if ([user_profile[@"gender"] isEqualToString:@"1"]) {
                    self.sexImg.image = [UIImage imageNamed:@"jianzhi-button-nan02"];
                }else{
                    self.sexImg.image = [UIImage imageNamed:@"fujin-nv03"];
                }
                self.disLab.text = responseObject[@"data"][@"distance"];
             
                self.tagLab.text = [NSString stringWithFormat:@"%@cm %@kg",user_profile[@"height"],user_profile[@"weight"]];
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

-(void)buildTextView{
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = RGBA(241, 241, 241, 1).CGColor;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.placeholder = @"可以具体描述身体不适的情况，对足疗师的要求和期望达到的效果等";
    self.textView.placeholderFont = [UIFont systemFontOfSize:6];
    self.textView.delegate = self;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
    
    [self.yajinBtn setAttributedTitle:str forState:UIControlStateNormal];
}

//押金认证
- (IBAction)yajinClick:(id)sender {
    ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
