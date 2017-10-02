//
//  ATQTypePeoDetailViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTypePeoDetailViewController.h"
#import "UIColor+LhkhColor.h"
@interface ATQTypePeoDetailViewController ()<UITextViewDelegate>

@end

@implementation ATQTypePeoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下单约TA";
    [self buildTextView];
}

-(void)buildTextView{
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = RGBA(241, 241, 241, 1).CGColor;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.placeholder = @"可以具体描述身体不适的情况，对足疗师的要求和期望达到的效果等";
    self.textView.placeholderFont = [UIFont systemFontOfSize:6];
    self.textView.delegate = self;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
    
    [self.yajinBtn setAttributedTitle:str forState:UIControlStateNormal];
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
