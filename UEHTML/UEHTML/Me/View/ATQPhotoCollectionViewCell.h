//
//  ATQPhotoCollectionViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^DeteleTupianBlock)();
@interface ATQPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *secretView;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (copy,nonatomic) DeteleTupianBlock deleteTupianblock;
@end
