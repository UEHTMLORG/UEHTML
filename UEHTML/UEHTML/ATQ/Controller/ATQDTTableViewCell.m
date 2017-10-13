//
//  ATQDTTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQDTTableViewCell.h"


@implementation ATQDTTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)huaClick:(id)sender {
    if (_huablock) {
        _huablock();
    }
}
- (IBAction)pinglunClick:(id)sender {
    if (_pinglunblock) {
        _pinglunblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
