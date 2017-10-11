//
//  ATQPHeaderView.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPHeaderView.h"

@implementation ATQPHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)buttonsAction:(UIButton *)sender {
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:clickAction:)]) {
        
        [self.delegate headerView:self clickAction:sender.tag];
        
    }
//    self.buttonBlock(sender.tag);
}

- (void)setButtonBlockAction:(ButtonActionBlock)block{

    self.buttonBlock = block;
}

@end
