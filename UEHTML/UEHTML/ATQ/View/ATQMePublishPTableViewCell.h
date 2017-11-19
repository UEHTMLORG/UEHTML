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
typedef void(^VedioselectBlock)();
@interface ATQMePublishPTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *publishCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *vedioImg;
@property (weak, nonatomic) IBOutlet UIButton *vedioBtn;
@property (nonatomic,strong)NSMutableArray *imgsArray;
@property (nonatomic,copy)XuanZeTuPianBlock xuanZeTuPianBlock;
@property (nonatomic,copy)DeleteTuPianBlock deleteTuPianBlock;
@property (nonatomic,copy)VedioselectBlock vedioselectBlock;
@end
