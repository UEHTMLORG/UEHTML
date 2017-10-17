//
//  ATQAddImgCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAddImgCollectionViewCell.h"

@implementation ATQAddImgCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)delImgClick:(id)sender {
    if (self.addImgCollectionDelBlock) {
        self.addImgCollectionDelBlock();
    }
}

@end
