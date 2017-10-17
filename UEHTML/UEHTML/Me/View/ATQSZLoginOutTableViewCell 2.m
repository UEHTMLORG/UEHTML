//
//  ATQSZLoginOutTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSZLoginOutTableViewCell.h"

@implementation ATQSZLoginOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.loginOutBtn.layer.cornerRadius = 4.f;
    self.loginOutBtn.layer.masksToBounds = YES;
}
- (IBAction)loginOutClick:(id)sender {
    if (_loginoutblock) {
        _loginoutblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
