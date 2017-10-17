//
//  ATQBuyjbFirTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBuyjbFirTableViewCell.h"
#import "UIColor+LhkhColor.h"
@implementation ATQBuyjbFirTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.guizeLab.layer.cornerRadius = 4.f;
    self.guizeLab.layer.masksToBounds = YES;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"充值会员享更多优惠"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr] range:strRange];
    
    [self.chongzhiVipBtn setAttributedTitle:str forState:UIControlStateNormal];
}
- (IBAction)chongzhiVipClick:(id)sender {
    if (_chongzhiVipblock) {
        _chongzhiVipblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
