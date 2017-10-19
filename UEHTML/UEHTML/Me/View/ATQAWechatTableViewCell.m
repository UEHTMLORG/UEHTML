//
//  ATQAWechatTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/26.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAWechatTableViewCell.h"

@implementation ATQAWechatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImg.layer.cornerRadius = 20.f;
    self.headImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
