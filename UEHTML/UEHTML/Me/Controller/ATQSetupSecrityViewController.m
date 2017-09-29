//
//  ATQSetupSecrityViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/26.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSetupSecrityViewController.h"
#import "ATQYZSecretViewController.h"
#import "ATQSecretView.h"
#import "PZXVerificationCodeView.h"
@interface ATQSetupSecrityViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)ATQSecretView *passwordView;
@property(nonatomic,strong)PZXVerificationCodeView *pzxView;
@end

@implementation ATQSetupSecrityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置密码";
    _pzxView = [[PZXVerificationCodeView alloc]initWithFrame:CGRectMake(0, 0, self.secretView.frame.size.width, self.secretView.frame.size.height)];
    _pzxView.selectedColor = [UIColor blackColor];
    _pzxView.VerificationCodeNum = 6;
    _pzxView.isSecure = NO;
    _pzxView.Spacing = 0;//每个格子间距属性
    [self.secretView addSubview:self.pzxView];
    
}

- (IBAction)sureClick:(id)sender {
    
    [_pzxView getVertificationCode];
    NSLog(@"----++++++%@",_pzxView.vertificationCode);
    ATQYZSecretViewController *vc = [[ATQYZSecretViewController  alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    for (UITextField *tf in _pzxView.textFieldArray) {
        
        [tf resignFirstResponder];
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
