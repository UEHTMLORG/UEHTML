//
//  ATQAccountThiTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAccountThiTableViewCell.h"
#import "UIColor+LhkhColor.h"
@implementation ATQAccountThiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tixianBtn.layer.cornerRadius = 5.f;
    self.tixianBtn.layer.masksToBounds = YES;
    self.tixianBtn.layer.borderWidth = 1.f;
    self.tixianBtn.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
}
- (IBAction)tixianClick:(id)sender {
    if (_tixianblock) {
        _tixianblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
