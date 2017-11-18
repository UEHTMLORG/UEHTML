//
//  FaBuFirstTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FuWuTypeCollectionViewCell.h"

@interface FaBuFirstTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) UIButton *currentButton;
@property (nonatomic, copy) NSString *currentType;

@end
