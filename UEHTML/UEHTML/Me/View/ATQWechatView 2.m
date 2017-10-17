//
//  ATQWechatView.m
//  UEHTML
//
//  Created by LHKH on 2017/9/26.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQWechatView.h"
#import "UIColor+LhkhColor.h"
@implementation ATQWechatView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    self.firView.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
    self.firView.layer.borderWidth = 1.f;
    self.firView.layer.cornerRadius = 4.f;
    self.firView.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 4.f;
    self.saveBtn.layer.masksToBounds = YES;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"如何找到自己的微信号"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr] range:strRange];
    
    [self.searchWechatBtn setAttributedTitle:str forState:UIControlStateNormal];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (IBAction)searchClick:(id)sender {
    if (_searchblock) {
        _searchblock();
    }
}
- (IBAction)saveClick:(id)sender {
    if (_saveblock) {
        _saveblock();
    }
}

+ (ATQWechatView *)wechatView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

@end
