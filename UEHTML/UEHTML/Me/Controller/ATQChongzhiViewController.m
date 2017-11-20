//
//  ATQChongzhiViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQChongzhiViewController.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "MBProgressHUD+Add.h"
#import "LhkhHttpsManager.h"
@interface ATQChongzhiViewController ()<UITextFieldDelegate>
{
    UIButton *selectedBtn;
    UITextField *othertextField;
    NSString *payStr;
}
@property (strong,nonatomic)NSMutableArray *priceArr;

@end

@implementation ATQChongzhiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户充值";
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 667);
    _priceArr = [NSMutableArray array];
    payStr = @"wechatPay";
    if ([self.chongzhiType isEqualToString:@"buyjinbi"]) {
        self.view1.hidden = NO;
        self.view2.hidden = YES;
        self.jineLab.text = self.chongzhijine;
    }else{
        self.view1.hidden = YES;
        self.view2.hidden = NO;
        [self loadData];
    }

}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/recharge/price_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----buy_show=%@",responseObject);
       
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                _priceArr = responseObject[@"data"][@"list"];
                [self buildJineView];
            }
           
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)buildJineView{
    NSInteger k = 0;
    float width = (ScreenWidth - 70)/4;
    float height = (self.jineView.frame.size.height - 40)/2;
    long hang = (_priceArr.count +4)/4;
    if (hang == 1) {
        _topH.constant = 80;
    }else{
        _topH.constant = 140;
    }
    for (int i = 0; i<hang; i++) {
        for (int j = 0; j<4; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20 + j*(width+10), 15 +i*(height+10), width, height)];
            btn.backgroundColor = [UIColor whiteColor];
            btn.layer.cornerRadius = 4.f;
            btn.layer.masksToBounds = YES;
            [btn setTitleColor:[UIColor colorWithHexString:UIToneTextColorStr] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            if (k<_priceArr.count) {
                btn.tag = 100+k;
                NSString *price = _priceArr[k][@"gold"];
                [btn setTitle:[NSString stringWithFormat:@"%.f元",price.floatValue] forState:UIControlStateNormal];
            }
            if ((k) == _priceArr.count) {
                btn.tag = 100+k;
                [btn setTitle:@"其他金额" forState:UIControlStateNormal];
                othertextField = [[UITextField alloc] initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
                othertextField.delegate = self;
                othertextField.layer.cornerRadius = 4.f;
                othertextField.layer.masksToBounds = YES;
                othertextField.placeholder = @"其他金额";
                othertextField.keyboardType = UIKeyboardTypeNumberPad;
                othertextField.backgroundColor = [UIColor whiteColor];
                othertextField.textAlignment = NSTextAlignmentCenter;
                othertextField.textColor = [UIColor colorWithHexString:UIColorStr];
                [self.jineView addSubview:othertextField];
            }
            /*
            if (k==0) {
                btn.tag = 100;
                [btn setTitle:_priceArr[k][@"price"] forState:UIControlStateNormal];
            }else if (k==1){
                btn.tag = 101;
                [btn setTitle:@"50元" forState:UIControlStateNormal];
            }else if (k==2){
                btn.tag = 102;
                [btn setTitle:@"100元" forState:UIControlStateNormal];
            }else if (k==3){
                btn.tag = 103;
                [btn setTitle:@"200元" forState:UIControlStateNormal];
            }else if (k==4){
                btn.tag = 104;
                [btn setTitle:@"300元" forState:UIControlStateNormal];
            }else if (k==5){
                btn.tag = 105;
                [btn setTitle:@"500元" forState:UIControlStateNormal];
            }else if (k==6){
                btn.tag = 106;
                [btn setTitle:@"1000元" forState:UIControlStateNormal];
            }else if (k==7){
                btn.tag = 107;
                [btn setTitle:@"其他金额" forState:UIControlStateNormal];
                othertextField = [[UITextField alloc] initWithFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y, btn.frame.size.width, btn.frame.size.height)];
                othertextField.delegate = self;
                othertextField.layer.cornerRadius = 4.f;
                othertextField.layer.masksToBounds = YES;
                othertextField.placeholder = @"其他金额";
                othertextField.keyboardType = UIKeyboardTypeNumberPad;
                othertextField.backgroundColor = [UIColor whiteColor];
                othertextField.textAlignment = NSTextAlignmentCenter;
                othertextField.textColor = [UIColor colorWithHexString:UIColorStr];
                [self.jineView addSubview:othertextField];
            }*/
            [self.jineView addSubview:btn];
            if (ScreenWidth <= 320) {
                btn.titleLabel.font = [UIFont systemFontOfSize:12];
                othertextField.font = [UIFont systemFontOfSize:12];
            }else{
                btn.titleLabel.font = [UIFont systemFontOfSize:16];
                othertextField.font = [UIFont systemFontOfSize:16];
            }
            k++;
        }
        
    }

}

-(void)click:(UIButton*)sender{
    NSLog(@"%ld%@",(long)sender.tag,sender.titleLabel.text);
    if (selectedBtn) {
        selectedBtn.layer.borderColor = [UIColor colorWithHexString:UIBgColorStr].CGColor;
        selectedBtn.layer.borderWidth = 1.f;
        [selectedBtn setTitleColor:[UIColor colorWithHexString:UIToneTextColorStr] forState:UIControlStateNormal];
        
    }
    selectedBtn = sender;
    selectedBtn.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
    selectedBtn.layer.borderWidth = 1.f;
    [selectedBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];
    [othertextField resignFirstResponder];
    othertextField.text =@"";
    if (sender.tag == (100+_priceArr.count)) {
        [othertextField becomeFirstResponder];
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    
}

- (IBAction)wechatPay:(id)sender {
    [othertextField resignFirstResponder];
    self.aliBtn.selected = NO;
    self.wechatBtn.selected = !self.aliBtn.selected;
    payStr = @"wechatPay";
}

- (IBAction)AliPay:(id)sender {
    [othertextField resignFirstResponder];
    self.wechatBtn.selected = NO;
    self.aliBtn.selected = !self.wechatBtn.selected;
    payStr = @"AliPay";
}
- (IBAction)sureClick:(id)sender {
    
    NSLog(@"%@%@%@",selectedBtn.titleLabel.text,othertextField.text,payStr);
    if (othertextField.text.length > 0 && ![othertextField.text isEqualToString:@""] && othertextField.text != nil) {
        if (othertextField.text.floatValue <25 || othertextField.text.floatValue > 10000) {
            [MBProgressHUD show:@"可充值金额范围为25-10000元,请正确输入金额" view:self.view];
            return;
        }
    }else{
        NSString *jineStr = [selectedBtn.titleLabel.text stringByReplacingOccurrencesOfString:@"元" withString:@""];
        NSLog(@"%.f",jineStr.floatValue);
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
