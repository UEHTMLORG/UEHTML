//
//  ATQMeHeadView.m
//  UEHTML
//
//  Created by LHKH on 2017/9/23.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMeHeadView.h"

@implementation ATQMeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)setupClick:(id)sender {
    if (_setupblock) {
        _setupblock();
    }
}

+ (ATQMeHeadView *)meHeadView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

@end
