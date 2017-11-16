//
//  ATQChaWechatViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/16.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQChaWechatViewController.h"
#import "UIColor+LhkhColor.h"
#import "ATQYajinRZViewController.h"
@interface ATQChaWechatViewController ()
@property (weak, nonatomic) IBOutlet UILabel *jineLab;
@property (weak, nonatomic) IBOutlet UILabel *renzhengLab;
@property (weak, nonatomic) IBOutlet UIButton *renzhengBtn;
@property (weak, nonatomic) IBOutlet UIButton *chakanBtn;

@end

@implementation ATQChaWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"查看微信号";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
    
    [self.renzhengBtn setAttributedTitle:str forState:UIControlStateNormal];
    self.chakanBtn.layer.cornerRadius = 4.f;
    self.chakanBtn.layer.masksToBounds = YES;
}
- (IBAction)renzhengClick:(id)sender {
    ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)chakanClick:(id)sender {
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
