//
//  ATQSecendTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSecendTableViewCell.h"
#import "UIColor+LhkhColor.h"

@implementation ATQSecendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.setSwitch.onTintColor = [UIColor colorWithHexString:UIColorStr];
    self.setSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
}
- (IBAction)switchClick:(id)sender {
}
- (IBAction)setupClick:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
