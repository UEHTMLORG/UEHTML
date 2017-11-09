//
//  ATQModifyUserInfoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQModifyUserInfoViewController.h"

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
    
    if ([self.delegate respondsToSelector:@selector(passmodifyValue:type:)]) {
        [self.delegate passmodifyValue:self.passValueText.text type:_natitle];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
