//
//  ATQOpinionPhotoTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^XuanZeTuPianBlock)();
typedef void(^DeleteSCTuPianBlock)();
@interface ATQOpinionPhotoTableViewCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *imgsArray;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic,copy)XuanZeTuPianBlock xuanZeTuPianBlock;
@property (nonatomic,copy)DeleteSCTuPianBlock deleteSCTuPianBlock;
@end
