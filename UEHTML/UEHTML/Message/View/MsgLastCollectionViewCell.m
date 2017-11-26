//
//  MsgLastCollectionViewCell.m
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "MsgLastCollectionViewCell.h"

@implementation MsgLastCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindDataWith:(MsgLastZaiXianModel *)model{
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"jianzhi-car"]];
    self.statueLabel.text = model.login_status;
    self.avtiveTimeLabel.text = model.actived_at;
}

@end
