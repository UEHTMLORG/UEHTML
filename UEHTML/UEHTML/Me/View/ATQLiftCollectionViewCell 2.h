//
//  ATQLiftCollectionViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQLiftCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *liftImg;
@property (weak, nonatomic) IBOutlet UILabel *liftName;
@property (weak, nonatomic) IBOutlet UIView *badgeview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *badgeViewW;


@end
