//
//  ATQBlacklistTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBlacklistTableViewCell.h"

@implementation ATQBlacklistTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.blackBtn.layer.cornerRadius = 4.f;
    self.blackBtn.layer.masksToBounds = YES;
}
- (IBAction)blackClick:(id)sender {
    if (_blackBlock) {
        _blackBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
