//
//  ATQOpinionTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQOpinionTableViewCell.h"
@interface ATQOpinionTableViewCell ()<UITextViewDelegate>
@end
@implementation ATQOpinionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.opinionTextView.layer.borderWidth = 1.f;
    self.opinionTextView.layer.masksToBounds = YES;
    self.opinionTextView.layer.borderColor = RGBA(241, 241, 241, 1).CGColor;
    self.opinionTextView.layer.cornerRadius = 5.f;
    self.opinionTextView.placeholder = @"请输入您的意见反馈，可截上图";
    self.opinionTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
