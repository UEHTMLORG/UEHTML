//
//  ATQMyAlumbSCTTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShangchuanTuPianBlock)();
typedef void(^DeleteSCTuPianBlock)();
@interface ATQMyAlumbSCTTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic,strong)NSMutableArray *imgsArray;
@property (nonatomic,copy)ShangchuanTuPianBlock shangchuanTuPianBlock;
@property (nonatomic,copy)DeleteSCTuPianBlock deleteSCTuPianBlock;
@end
