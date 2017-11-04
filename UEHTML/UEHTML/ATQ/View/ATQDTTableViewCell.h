//
//  ATQDTTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQDTModel;

@protocol ATQDTTableViewCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
-(void)didClickImageViewWithCurrentCell:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;

@end
@interface ATQDTTableViewCell : UITableViewCell

@property (nonatomic,weak)id <ATQDTTableViewCellDelegate>delegate;

- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath;
@end
