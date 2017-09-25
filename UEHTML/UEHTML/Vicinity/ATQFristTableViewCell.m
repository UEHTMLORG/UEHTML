//
//  ATQFristTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQFristTableViewCell.h"

@implementation ATQFristTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)accounClick:(id)sender {
    if (_myaccountblock) {
        _myaccountblock();
    }
}
- (IBAction)albumClick:(id)sender {
    if (_myalbumblock) {
        _myalbumblock();
    }
}
- (IBAction)spreadClick:(id)sender {
    if (_spreadblock) {
        _spreadblock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
