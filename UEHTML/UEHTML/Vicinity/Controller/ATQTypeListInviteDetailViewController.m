//
//  ATQTypeListInviteDetailViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTypeListInviteDetailViewController.h"
#import "UIColor+LhkhColor.h"
#import "ATQYajinRZViewController.h"
@interface ATQTypeListInviteDetailViewController ()<UITextViewDelegate>

@end

@implementation ATQTypeListInviteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下单应邀";
    [self buildTextView];
}
-(void)buildTextView{
    self.beizhuText.layer.borderWidth = 1.f;
    self.beizhuText.layer.masksToBounds = YES;
    self.beizhuText.layer.borderColor = RGBA(241, 241, 241, 1).CGColor;
    self.beizhuText.layer.cornerRadius = 5.f;
    self.beizhuText.placeholder = @"可以具体描述身体不适的情况，对足疗师的要求和期望达到的效果等";
    self.beizhuText.placeholderFont = [UIFont systemFontOfSize:6];
    self.beizhuText.delegate = self;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
    
    [self.yajinRZBtn setAttributedTitle:str forState:UIControlStateNormal];
}

- (IBAction)selectTimeClick:(id)sender {
}
- (IBAction)yajinRZClick:(id)sender {
    ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)sureInviteClick:(id)sender {
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
