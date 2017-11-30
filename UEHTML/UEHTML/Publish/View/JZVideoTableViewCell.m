//
//  JZVideoTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JZVideoTableViewCell.h"

@implementation JZVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)bindWithModel:(JZVideoCellModel *)model{
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"jianzhi-car"]];
    self.nickNameLabel.text = model.nick_name;
    self.shiJianLabel.text = model.start_time;
    self.shiChangLabel.text = model.video_time;
    NSString * string = [NSString stringWithFormat:@"%@岁 %@cm %@kg",model.age,model.height,model.weight];
    self.infoLabel.text = string;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
