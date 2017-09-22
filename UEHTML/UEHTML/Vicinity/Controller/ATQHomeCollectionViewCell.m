//
//  ATQHomeCollectionViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQHomeCollectionViewCell.h"

@implementation ATQHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.itemImg.layer.cornerRadius = 4.f;
    self.itemImg.layer.masksToBounds = YES;
    self.chatBtn.layer.cornerRadius = 4.f;
    self.chatBtn.layer.masksToBounds = YES;
}
- (IBAction)chatClick:(id)sender {
    if (self.chatClick) {
        self.chatClick ();
    }
}

@end
