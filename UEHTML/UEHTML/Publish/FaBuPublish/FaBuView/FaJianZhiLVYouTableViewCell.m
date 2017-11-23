//
//  FaJianZhiLVYouTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "FaJianZhiLVYouTableViewCell.h"

@implementation FaJianZhiLVYouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.tiJiaoButton.layer setCornerRadius:5.0];
    [self.tiJiaoButton.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
