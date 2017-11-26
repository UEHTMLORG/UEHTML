//
//  MsgLastCollectionViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgLastZaiXianModel.h"
@interface MsgLastCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *avtiveTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *statueLabel;

- (void)bindDataWith:(MsgLastZaiXianModel *)model;

@end
