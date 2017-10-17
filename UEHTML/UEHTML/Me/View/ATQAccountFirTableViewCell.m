//
//  ATQAccountFirTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAccountFirTableViewCell.h"

@implementation ATQAccountFirTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)jinbiClick:(id)sender {
    if (_jinbiblock) {
        _jinbiblock();
    }
}
- (IBAction)liwuClick:(id)sender {
    if (_liwublock) {
        _liwublock();
    }
}
- (IBAction)vipClick:(id)sender {
    if (_vipblock) {
        _vipblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
