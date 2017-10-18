//
//  JianZhiTouSuViewController.h
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import <TZImagePickerController.h>
#import "JianZhiTouSuCollectionViewCell.h"


@interface JianZhiTouSuViewController : ATQBaseViewController<TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIImageView *touXiangImageViewe;
@property (strong, nonatomic) IBOutlet UILabel *niChengLabel;
@property (strong, nonatomic) IBOutlet UITextView *subMessageTextView;
@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (nonatomic, strong) NSMutableArray *photosARR;

@end
