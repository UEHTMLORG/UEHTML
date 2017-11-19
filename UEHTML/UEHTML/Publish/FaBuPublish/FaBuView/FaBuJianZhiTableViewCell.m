//
//  FaBuJianZhiTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "FaBuJianZhiTableViewCell.h"

@implementation FaBuJianZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.tiJiaoShenHeButton.layer setCornerRadius:5.0];
    [self.tiJiaoShenHeButton.layer setMasksToBounds:YES];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
