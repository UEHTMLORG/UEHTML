//
//  ATQBuyVipViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBuyVipViewController.h"
#import "UIColor+LhkhColor.h"
@interface ATQBuyVipViewController (){
    NSString *payStr;
}

@end

@implementation ATQBuyVipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买会员";
    
    [self buildinitView];
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
