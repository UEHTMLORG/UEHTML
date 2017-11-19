//
//  ATQMyFriendsTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyFriendsTableViewCell.h"
#import "ATQFriModel.h"

@implementation ATQMyFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)xuanzeClick:(id)sender {
    if (_selectblock) {
        _selectblock();
    }
}

-(void)configCellWithModel:(ATQFriModel *)model{
    if (model.isSelected) {
        [self.xuanzeBtn setImage:[UIImage imageNamed:@"zhanghu-dian"] forState:UIControlStateNormal];
    }else{
        [self.xuanzeBtn setImage:[UIImage imageNamed:@"zhanghu-dian02"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
