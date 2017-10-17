//
//  ATQNewFriendsTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQNewFriendsTableViewCell.h"

@implementation ATQNewFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImg.layer.cornerRadius = 20.f;
    self.userImg.layer.masksToBounds = YES;
    self.addBtn.layer.masksToBounds = YES;
    self.addBtn.layer.cornerRadius = 4.f;
}
- (IBAction)addClick:(id)sender {
    if (_addfriendsblock) {
        _addfriendsblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
