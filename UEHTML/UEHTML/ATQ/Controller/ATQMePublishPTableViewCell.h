//
//  ATQMePublishPTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^XuanZeTuPianBlock)();
typedef void(^DeleteTuPianBlock)();
@interface ATQMePublishPTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *publishCollectionView;
@property (nonatomic,strong)NSMutableArray *imgsArray;
@property (nonatomic,copy)XuanZeTuPianBlock xuanZeTuPianBlock;
@property (nonatomic,copy)DeleteTuPianBlock deleteTuPianBlock;
@end
