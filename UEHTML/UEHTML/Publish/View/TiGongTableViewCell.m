//
//  TiGongTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "TiGongTableViewCell.h"

@implementation TiGongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindWithMyModel:(FuWuFangMyListCellModel *)model{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@implementation FuWuFangTuiJianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)bindWithTuiJianModel:(FuWuFangTuiJianCellModel *)model{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
