//
//  ATQAddImgCollectionViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AddImgCollectionDelBlock)();
@interface ATQAddImgCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selImg;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (nonatomic,copy)AddImgCollectionDelBlock addImgCollectionDelBlock;
@end
