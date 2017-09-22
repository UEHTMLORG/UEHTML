//
//  ATQRecPerCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRecPerCollectionViewCell.h"
#import "UIColor+LhkhColor.h"

@implementation ATQRecPerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bzLab1.layer.cornerRadius = 4.f;
    self.bzLab1.layer.masksToBounds = YES;
    self.bzLab2.layer.cornerRadius = 4.f;
    self.bzLab2.layer.masksToBounds = YES;
    self.bzLab2.layer.borderWidth = 1.f;
    self.bzLab2.layer.borderColor = [UIColor colorWithHexString:UIColorStr].CGColor;
}

@end
