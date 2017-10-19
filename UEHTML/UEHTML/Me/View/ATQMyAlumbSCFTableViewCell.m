//
//  ATQMyAlumbSCFTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyAlumbSCFTableViewCell.h"
@interface ATQMyAlumbSCFTableViewCell ()<UITextViewDelegate>
@end
@implementation ATQMyAlumbSCFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoText.placeholder = @"请输入照片描述";
    self.photoText.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
