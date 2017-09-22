//
//  ATQHomeCollectionViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^chatBlock)();
@interface ATQHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *attrLab;
@property (weak, nonatomic) IBOutlet UIButton *chatBtn;
@property (copy, nonatomic) chatBlock chatClick;

@end
