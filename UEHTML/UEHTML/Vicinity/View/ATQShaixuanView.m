//
//  ATQShaixuanView.m
//  UEHTML
//
//  Created by LHKH on 2017/11/13.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQShaixuanView.h"
#import "UIColor+LhkhColor.h"
@interface ATQShaixuanView()<ATQShaixuanViewDelegate>{
    NSString *sexStr;
    NSString *ageStr;
    NSString *heightStr;
    NSString *distenceStr;
    NSString *gongqiuStr;
    UIButton *selectSexBtn;
    UIButton *selectAgeBtn;
    UIButton *selectHeightBtn;
    UIButton *selectDistenceBtn;
    UIButton *selectGongqiuBtn;
}

@end

@implementation ATQShaixuanView

#pragma mark - Life Cycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.sexBXBtn.selected = YES;
        self.ageBXBtn.selected = YES;
        self.heightBXBtn.selected = YES;
        self.disBXBtn.selected = YES;
        self.fwBXBtn.selected = YES;
    }
    return self;
}

+ (ATQShaixuanView *)meHeadView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}
#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests
//性别
- (IBAction)sexBXClick:(UIButton*)sender {
    if (selectSexBtn) {
        [selectSexBtn setTitleColor:[UIColor colorWithHexString:UIDeepToneTextColorStr] forState:UIControlStateNormal];
    }
    selectSexBtn = sender;
    [selectSexBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];

    sexStr = sender.titleLabel.text;
}

//年龄
- (IBAction)ageBXClick:(UIButton*)sender {
    
    if (selectAgeBtn) {
        [selectAgeBtn setTitleColor:[UIColor colorWithHexString:UIDeepToneTextColorStr] forState:UIControlStateNormal];
    }
    selectAgeBtn = sender;
    [selectAgeBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];
    ageStr = sender.titleLabel.text;
}

//身高
- (IBAction)heightClick:(UIButton*)sender {

    if (selectHeightBtn) {
        [selectHeightBtn setTitleColor:[UIColor colorWithHexString:UIDeepToneTextColorStr] forState:UIControlStateNormal];
    }
    selectHeightBtn = sender;
    [selectHeightBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];
    heightStr = sender.titleLabel.text;
}

//距离
- (IBAction)distenseClick:(UIButton*)sender {
   
    if (selectDistenceBtn) {
        [selectDistenceBtn setTitleColor:[UIColor colorWithHexString:UIDeepToneTextColorStr] forState:UIControlStateNormal];
    }
    selectDistenceBtn = sender;
    [selectDistenceBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];
    distenceStr = sender.titleLabel.text;
}

//供求
- (IBAction)xuqiuClick:(UIButton*)sender {
    if (selectGongqiuBtn) {
        [selectGongqiuBtn setTitleColor:[UIColor colorWithHexString:UIDeepToneTextColorStr] forState:UIControlStateNormal];
    }
    selectGongqiuBtn = sender;
    [selectGongqiuBtn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateNormal];
    gongqiuStr = sender.titleLabel.text;
}


- (IBAction)chongzhiClick:(UIButton*)sender {
    
}

- (IBAction)sureClick:(UIButton*)sender {
    if ([_delegate respondsToSelector:@selector(shaixuanViewClick:age:height:distence:gongqiu:)]) {
        [_delegate shaixuanViewClick:sexStr age:ageStr height:heightStr distence:distenceStr gongqiu:gongqiuStr];
    }
}

#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

