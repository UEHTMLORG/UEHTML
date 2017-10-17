//
//  ATQSZFirTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSZFirTableViewCell.h"

@implementation ATQSZFirTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImg.layer.cornerRadius = 20.f;
    self.userImg.layer.masksToBounds = YES;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
