//
//  ATQSetupSecrityViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/26.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSetupSecrityViewController.h"
#import "ATQSecretView.h"
@interface ATQSetupSecrityViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)ATQSecretView *passwordView;
@end

@implementation ATQSetupSecrityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置密码";
//    self.passwordView = [[ATQSecretView alloc] initWithFrame:CGRectMake(0, 0, 240, 45)];
//    [self.secretView addSubview:self.passwordView];
    
}
- (IBAction)text1CLick:(id)sender {
    if (self.text1.text.length == 1) {
        [self.text2 becomeFirstResponder];
    }
}
- (IBAction)text2CLick:(id)sender {
    if (self.text2.text.length == 1) {
        [self.text3 becomeFirstResponder];
    }
}
- (IBAction)text3Click:(id)sender {
    if (self.text3.text.length == 1) {
        [self.text4 becomeFirstResponder];
    }
}
- (IBAction)text4Click:(id)sender {
    if (self.text4.text.length == 1) {
        [self.text5 becomeFirstResponder];
    }
}
- (IBAction)text5Click:(id)sender {
    if (self.text5.text.length == 1) {
        [self.text6 becomeFirstResponder];
    }
}
- (IBAction)text6Click:(id)sender {
//    if (self.text6.text.length == 1) {
//        [self.text6 resignFirstResponder];
//    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.text1 && self.text1.text.length == 1) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSLog(@"变化%@", string);
//    if (self.text1.text.length == 1) {
//        [self.text2 becomeFirstResponder];
//    }
//    if(string.length ==1 ) {
//        //按回车关闭键盘
//        [textField resignFirstResponder];
//        [self.text2 becomeFirstResponder];
//        return NO;
//    } else if(string.length == 0) {
//        //判断是不是删除键
//        return YES;
//    } else {
//        return YES;
//    }
    return YES;
}

- (IBAction)sureClick:(id)sender {
    
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
