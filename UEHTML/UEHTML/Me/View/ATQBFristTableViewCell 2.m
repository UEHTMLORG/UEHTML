//
//  ATQBFristTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBFristTableViewCell.h"

@implementation ATQBFristTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)accountClick:(id)sender {
    if (_vipmyaccountblock) {
        _vipmyaccountblock();
    }
}
- (IBAction)albumClick:(id)sender {
    if (_vipmyalbumblock) {
        _vipmyalbumblock();
    }
}
- (IBAction)spreadClick:(id)sender {
    if (_vipspreadblock) {
        _vipspreadblock();
    }
}
- (IBAction)businessClick:(id)sender {
    if (_vipmybusinessblock) {
        _vipmybusinessblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
