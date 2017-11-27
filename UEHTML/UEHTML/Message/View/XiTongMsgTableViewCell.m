//
//  XiTongMsgTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "XiTongMsgTableViewCell.h"

@implementation XiTongMsgTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
