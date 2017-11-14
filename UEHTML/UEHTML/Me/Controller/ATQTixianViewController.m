//
//  ATQTixianViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/14.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQTixianViewController.h"

@interface ATQTixianViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankLab;
@property (weak, nonatomic) IBOutlet UITextField *bankNumText;
@property (weak, nonatomic) IBOutlet UILabel *ketixianJine;
@property (weak, nonatomic) IBOutlet UITextField *tixianJineText;
@property (weak, nonatomic) IBOutlet UIView *bankView;

@end

@implementation ATQTixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请提现";
    self.bankView.layer.cornerRadius = 4.f;
    self.bankView.layer.masksToBounds = YES;
    self.bankView.layer.borderColor = RGBA(240, 240, 240, 1).CGColor;
    self.bankView.layer.borderWidth = 1.f;
    self.bankNumText.layer.cornerRadius = 4.f;
    self.bankNumText.layer.masksToBounds = YES;
    self.bankNumText.layer.borderColor = RGBA(240, 240, 240, 1).CGColor;
    self.bankNumText.layer.borderWidth = 1.f;
}
- (IBAction)bankClick:(id)sender {
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
