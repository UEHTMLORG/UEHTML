//
//  ATQMeHeadView.m
//  UEHTML
//
//  Created by LHKH on 2017/9/23.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMeHeadView.h"

@implementation ATQMeHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (IBAction)setupClick:(id)sender {
    if (_setupblock) {
        _setupblock();
    }
}

+ (ATQMeHeadView *)meHeadView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

@end
