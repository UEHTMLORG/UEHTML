//
//  ATQPhotoCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPhotoCollectionViewCell.h"

@implementation ATQPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)deleteTupianClick:(id)sender {
    if (_deleteTupianblock) {
        _deleteTupianblock();
    }
}

@end
