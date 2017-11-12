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
    [self.avatarImage.layer setCornerRadius:30.0f];
    [self.avatarImage.layer setMasksToBounds:YES];
}

- (void)bindWithMyModel:(FuWuFangMyListCellModel *)model{
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    self.nickNameLabel.text = model.nick_name;
    self.ageLabel.text = model.age;
    self.infoLabel.text = [NSString stringWithFormat:@"%@元/小时  %@小时",model.unit_price,model.service_time];
    self.mioneyLabel.text = model.job_class_name;

    if ([model.card_level intValue] > 0) {
        self.vipImage.hidden = NO;
    }else{
        self.vipImage.hidden = YES;
    }
    if ([model.car_logo isEqualToString:@""]) {
        self.carImage.hidden = YES;
        
    }
    else{
        self.carImage.hidden = NO;
        [self.carImage sd_setImageWithURL:[NSURL URLWithString:model.car_logo] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    }
    int type = [model.deposit_auth?:@"1" intValue];
    switch (type) {
            //押金认证  1  平民 2商人 3财主 4知县 5总督 6帝王
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
        case 6:{
            
        }
            break;
        default:
            break;
    }
    self.statusLabel.text = model.status_title;
    if ([model.status isEqualToString:@"0"]) {
        self.dateLabel.hidden = YES;
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
    }
    else{
        self.dateLabel.hidden = NO;
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
    }
    self.dateLabel.text = model.create_time;
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
    [self.avatarImage.layer setCornerRadius:30.0f];
    [self.avatarImage.layer setMasksToBounds:YES];
}

- (void)bindWithTuiJianModel:(FuWuFangTuiJianCellModel *)model{
    
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    self.nickNameLabel.text = model.nick_name;
    self.ageLabel.text = model.age;
    self.juliLabel.text = model.distance;
    self.moneyLabel.text = [NSString stringWithFormat:@"线下服务：%@ %@元/小时",model.job_class_name,model.price];
    self.infoLabel.text = model.introduce;
    self.chengLabel.text = model.credit_num;
    if ([model.card_level intValue] > 0) {
        self.vipImage.hidden = NO;
    }else{
        self.vipImage.hidden = YES;
    }
    if ([model.car_auth isEqualToString:@"1"]) {
        self.carImage.hidden = NO;
        [self.carImage sd_setImageWithURL:[NSURL URLWithString:model.car_logo] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
    }
    else{
        self.carImage.hidden = YES;
    }
    int type = [model.deposit_auth?:@"1" intValue];
    switch (type) {
        //押金认证  1  平民 2商人 3财主 4知县 5总督 6帝王
        case 1:{
                
            }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            
        }
            break;
        case 4:{
            
        }
            break;
        case 5:{
            
        }
            break;
        case 6:{
            
        }
            break;
        default:
            break;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
