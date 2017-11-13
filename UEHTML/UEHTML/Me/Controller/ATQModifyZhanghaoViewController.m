//
//  ATQModifyZhanghaoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQModifyZhanghaoViewController.h"
#import "UIColor+LhkhColor.h"
@interface ATQModifyZhanghaoViewController ()<modifyPasszhanghuDelegate>{
    NSTimer *mTimer;
    int time;
}
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *haomaLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;

@end

@implementation ATQModifyZhanghaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账户安全";
    self.phoneText.text = self.passStr;
    self.codeBtn.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
    self.codeBtn.layer.borderWidth = 1;
    self.codeBtn.layer.cornerRadius = 4;
    self.codeBtn.layer.masksToBounds = YES;

}
- (IBAction)codeClick:(id)sender {
    [self startTimer];
}
- (IBAction)saveClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(passzhanghuValue:)]) {
        [self.delegate passzhanghuValue:self.phoneText.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 开始定时器
- (void) startTimer{
    // 定义一个NSTimer
    time = 60;
    mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(doTimer:)  userInfo:nil
                                             repeats:YES];
}

// 定时器执行的方法
- (void)doTimer:(NSTimer *)timer{
    time--;
    if (time > 0) {
        NSString *title = [NSString stringWithFormat:@"%ds重新获取",time];
        self.codeLab.text = title;
        self.codeLab.textAlignment = NSTextAlignmentCenter;
        [self.codeBtn setEnabled:false];
    }else{
        [self.codeBtn setEnabled:true];
        self.codeLab.text = @"重新获取";
        [self stopTimer];
    }
}

// 停止定时器
- (void) stopTimer{
    if (mTimer != nil){
        [mTimer invalidate];
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
