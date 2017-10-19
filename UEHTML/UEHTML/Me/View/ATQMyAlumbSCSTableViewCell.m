//
//  ATQMyAlumbSCSTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyAlumbSCSTableViewCell.h"
#import "UIColor+LhkhColor.h"
@implementation ATQMyAlumbSCSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.secretSwicth.onTintColor = [UIColor colorWithHexString:UIColorStr];
    self.secretSwicth.transform = CGAffineTransformMakeScale(0.75, 0.75);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
