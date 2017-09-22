//
//  ATQNewPCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQNewPCollectionViewCell.h"

@implementation ATQNewPCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personImg.layer.cornerRadius = 4.f;
    self.personImg.layer.masksToBounds = YES;
}

@end
