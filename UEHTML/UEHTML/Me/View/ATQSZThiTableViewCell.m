//
//  ATQSZThiTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSZThiTableViewCell.h"
#import "UIColor+LhkhColor.h"
@implementation ATQSZThiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.szSwitch.onTintColor = [UIColor colorWithHexString:@"8B8B8B"];
    self.szSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
