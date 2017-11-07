//
//  ATQMeDTTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/11/7.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQDTModel;
@protocol ATQMeDTTableViewCellDelegate <NSObject>

-(void)didClickMeMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
-(void)didClickMeImageViewWithCurrentCell:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;
-(void)didClickMeDelWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickMeHuaWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickMeCommentWithIndexPath:(NSIndexPath *)indexPath;
@end
@interface ATQMeDTTableViewCell : UITableViewCell
@property (nonatomic,weak)id <ATQMeDTTableViewCellDelegate>delegate;
- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath;
@end

