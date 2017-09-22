//
//  ATQItemTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/22.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end
