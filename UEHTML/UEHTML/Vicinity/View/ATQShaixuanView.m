//
//  ATQShaixuanView.m
//  UEHTML
//
//  Created by LHKH on 2017/11/13.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQShaixuanView.h"

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
    selectSexBtn.selected = !sender.selected;
    selectSexBtn = sender;
    sexStr = sender.titleLabel.text;
}

//年龄
- (IBAction)ageBXClick:(UIButton*)sender {
    selectAgeBtn.selected = !sender.selected;
    selectAgeBtn = sender;
    ageStr = sender.titleLabel.text;
}

//身高
- (IBAction)heightClick:(UIButton*)sender {
    selectHeightBtn.selected = !sender.selected;
    selectHeightBtn = sender;
    heightStr = sender.titleLabel.text;
}

//距离
- (IBAction)distenseClick:(UIButton*)sender {
    selectDistenceBtn.selected = !sender.selected;
    selectDistenceBtn = sender;
    distenceStr = sender.titleLabel.text;
}

//供求
- (IBAction)xuqiuClick:(UIButton*)sender {
    selectGongqiuBtn.selected = !sender.selected;
    selectGongqiuBtn = sender;
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

