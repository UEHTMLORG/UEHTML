//
//  ATQYJRZTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQYJRZTableViewCell.h"

@implementation ATQYJRZTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lvBtn.layer.cornerRadius = 4.f;
    self.lvBtn.layer.masksToBounds = YES;
}
- (IBAction)lvClick:(id)sender {
    if (_renzhengblock) {
        _renzhengblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
