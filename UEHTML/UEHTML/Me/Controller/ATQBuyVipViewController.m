//
//  ATQBuyVipViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBuyVipViewController.h"
#import "UIColor+LhkhColor.h"
#import "MBProgressHUD+Add.h"
#import "LhkhHttpsManager.h"
#import "UIImageView+WebCache.h"
@interface ATQBuyVipViewController (){
    NSString *payStr;
}
@property (strong,nonatomic)NSMutableArray *packageArr;
@property (strong,nonatomic)NSDictionary *userDic;
@end

@implementation ATQBuyVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买会员";
    [self loadData];
    [self buildinitView];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/card/buy_show",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----buy_show=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                _userDic = responseObject[@"data"][@"user"];
                _packageArr = responseObject[@"data"][@"package"];
                [self.userImg sd_setImageWithURL:[NSURL URLWithString:_userDic[@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];
                self.userNameLab.text = _userDic[@"nick_name"];
                NSString *card_level = _userDic[@"card_level"];
                if ([card_level isEqualToString:@"0"]) {
                    self.timeLab.text = @"您还不是会员额！";
                }else{
                    NSString *plus_day = _userDic[@"plus_day"];
                    NSString *card_endtime = _userDic[@"card_endtime"];
                    self.timeLab.text = [NSString stringWithFormat:@"剩余时间:%@ 到期时间:%@",plus_day,card_endtime];
                }
                if (_packageArr.count>0) {
                    NSDictionary *dic1 = _packageArr[0];
                    NSDictionary *dic2 = _packageArr[1];
                    NSDictionary *dic3 = _packageArr[2];
                    NSString *price1 = dic1[@"original_price"];
                    NSString *price2 = dic2[@"original_price"];
                    NSString *price3 = dic3[@"original_price"];
                    NSString *saleprice1 = dic1[@"price"];
                    NSString *saleprice2 = dic2[@"price"];
                    NSString *saleprice3 = dic3[@"price"];
                    self.vipLab1.text = [NSString stringWithFormat:@"%.f元",price1.floatValue] ;
                    
                    self.vipLab.text = [NSString stringWithFormat:@"%.f元",price1.floatValue] ;
                    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.vipLab.text]];
                    
                    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(pricestr.length - 1, 1)];
                    self.vipLab.attributedText = pricestr;
                    
                    [self.vipBtn1 setTitle:dic1[@"title"] forState:UIControlStateNormal];
                    [self.vipBtn1 setTitle:dic1[@"title"] forState:UIControlStateSelected];
                    self.vipSaleLab2.text = [NSString stringWithFormat:@"%.f元",price2.floatValue];
                    self.vipLab2.text = [NSString stringWithFormat:@"%.f元",saleprice2.floatValue];
                    [self.vipBtn2 setTitle:dic2[@"title"] forState:UIControlStateNormal];
                    [self.vipBtn2 setTitle:dic2[@"title"] forState:UIControlStateSelected];
                    self.vipSaleLab3.text = [NSString stringWithFormat:@"%.f元",price3.floatValue];
                    self.vipLab3.text = [NSString stringWithFormat:@"%.f元",saleprice3.floatValue];
                    [self.vipBtn3 setTitle:dic3[@"title"] forState:UIControlStateNormal];
                    [self.vipBtn3 setTitle:dic3[@"title"] forState:UIControlStateSelected];
                }
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

-(void)buildinitView{
    payStr = @"wechatPay";
    self.vipBtn1.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    self.vipSaleLab.hidden = YES;
    self.hengxianView.hidden = YES;
    if (ScreenWidth<=320) {
        self.timeLab.font = [UIFont systemFontOfSize:10];
        self.vipLab1.font = [UIFont systemFontOfSize:10];
        self.vipLab2.font = [UIFont systemFontOfSize:10];
        self.vipLab3.font = [UIFont systemFontOfSize:10];
        self.vipSaleLab1.font = [UIFont systemFontOfSize:10];
        self.vipSaleLab2.font = [UIFont systemFontOfSize:10];
        self.vipSaleLab3.font = [UIFont systemFontOfSize:10];
    }else{
        self.timeLab.font = [UIFont systemFontOfSize:14];
        self.vipLab1.font = [UIFont systemFontOfSize:14];
        self.vipLab2.font = [UIFont systemFontOfSize:14];
        self.vipLab3.font = [UIFont systemFontOfSize:14];
        self.vipSaleLab1.font = [UIFont systemFontOfSize:14];
        self.vipSaleLab2.font = [UIFont systemFontOfSize:14];
        self.vipSaleLab3.font = [UIFont systemFontOfSize:14];
    }

    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.vipLab.text]];
    
    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(pricestr.length - 1, 1)];
    
    self.vipLab.attributedText = pricestr;
    
}

- (IBAction)vip1Click:(id)sender {
    self.vipBtn1.selected = YES;
    self.vipBtn2.selected = self.vipBtn3.selected = !self.vipBtn1.selected;
    self.vipBtn1.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    self.vipBtn2.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipBtn3.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipLab.text = self.vipLab1.text;
    self.vipSaleLab.hidden = YES;
    self.hengxianView.hidden = YES;
    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.vipLab.text]];
    
    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(pricestr.length - 1, 1)];
    
    self.vipLab.attributedText = pricestr;
    
}
- (IBAction)vip2Click:(id)sender {
    self.vipBtn2.selected = YES;
    self.vipBtn1.selected = self.vipBtn3.selected = !self.vipBtn2.selected;
    self.vipBtn2.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    self.vipBtn1.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipBtn3.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipLab.text = self.vipLab2.text;
    self.vipSaleLab.hidden = NO;
    self.hengxianView.hidden = NO;
    self.vipSaleLab.text = self.vipSaleLab2.text;
    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.vipLab.text]];
    
    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(pricestr.length - 1, 1)];
    
    self.vipLab.attributedText = pricestr;
}
- (IBAction)vip3Click:(id)sender {
    self.vipBtn3.selected = YES;
    self.vipBtn1.selected = self.vipBtn2.selected = !self.vipBtn3.selected;
    self.vipBtn3.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    self.vipBtn2.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipBtn1.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    self.vipLab.text = self.vipLab3.text;
    self.vipSaleLab.text = self.vipSaleLab3.text;
    self.vipSaleLab.hidden = NO;
    self.hengxianView.hidden = NO;
    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",self.vipLab.text]];
    
    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(pricestr.length - 1, 1)];
    
    self.vipLab.attributedText = pricestr;
}
- (IBAction)duiClick:(id)sender {
    self.duiBtn.selected = !self.duiBtn.selected;
}
- (IBAction)wechatPayClick:(id)sender {
    self.aliBtn.selected = NO;
    self.wechatBtn.selected = !self.aliBtn.selected;
    payStr = @"wechatPay";
}
- (IBAction)aliPayClick:(id)sender {
    self.wechatBtn.selected = NO;
    self.aliBtn.selected = !self.wechatBtn.selected;
    payStr = @"aliPay";
}
- (IBAction)buyClick:(id)sender {
    NSLog(@"%@%@",payStr,self.vipLab.text);
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
