//
//  ATQMePublishFTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMePublishFTableViewCell.h"
@interface ATQMePublishFTableViewCell()<UITextViewDelegate,ATQMePublishFTableViewCellDelegate>
@end
@implementation ATQMePublishFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.publishTextView.placeholder = @"这一刻的想法...";
    self.publishTextView.delegate = self;
}


-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self.publishTextView endEditing:YES];
    if ([_delegate respondsToSelector:@selector(ATQMePublishFTableViewCellDelegate:)]) {
        [_delegate ATQMePublishFTableViewCellDelegate:self.publishTextView.text];
    }
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
