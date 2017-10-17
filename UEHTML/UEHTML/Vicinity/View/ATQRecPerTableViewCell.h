//
//  ATQRecPerTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQRecPerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *leftCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *midCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *rightCollectionView;

@end
