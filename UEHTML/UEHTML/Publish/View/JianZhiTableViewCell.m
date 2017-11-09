//
//  JianZhiTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiTableViewCell.h"

@implementation JianZhiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.avatarImageView.layer setCornerRadius:30.0f];
    [self.avatarImageView.layer setMasksToBounds:YES];
}

- (void)bindMyModel:(XuQiuFangMyListCellModel *)model{
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    self.nickNameLabel.text = model.nick_name;
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@ ",model.age,model.height,model.weight];
    self.jobModelLabel.text = [NSString stringWithFormat:@"%@ %@元/小时 %@小时",model.job_class_name, model.unit_price,model.service_time];
    self.status_titleLabel.text = model.status_title;
    self.timeLabel.text = model.create_time;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
}

@end

@implementation XuQiuFangTuiJianCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.avatarImageView.layer setCornerRadius:30.0f];
    [self.avatarImageView.layer setMasksToBounds:YES];
    // Initialization code
}

- (void)bindTuiJianModel:(XuQiuFangTuiJianCellModel *)model{
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    self.nickNameLabel.text = model.nick_name;
    self.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@ ",model.age,model.height,model.weight];
    self.chengNumLabel.text = model.credit_num;
    self.juliLabel.text = model.distance;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
