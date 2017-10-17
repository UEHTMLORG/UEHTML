//
//  ATQHomeRecCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/23.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQHomeRecCollectionViewCell.h"

@implementation ATQHomeRecCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recPImg.layer.cornerRadius = 4.f;
    self.recPImg.layer.masksToBounds = YES;
    self.lvLab.layer.cornerRadius = 4.f;
    self.lvLab.layer.masksToBounds = YES;
    
}

@end
