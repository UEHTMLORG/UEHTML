//
//  ATQDTTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^pinglunBlock)();
typedef void (^huaBlock)();
@interface ATQDTTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *weizhiLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *peoLab;
@property (weak, nonatomic) IBOutlet UILabel *huaLab;
@property (weak, nonatomic) IBOutlet UILabel *pinglunLab;
@property (copy, nonatomic) pinglunBlock pinglunblock;
@property (copy, nonatomic) huaBlock huablock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoCollectionViewH;
@end
