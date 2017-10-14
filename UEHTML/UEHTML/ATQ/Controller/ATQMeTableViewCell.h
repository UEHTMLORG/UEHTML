//
//  ATQMeTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQPYQModel;
@class ATQOperationView;
@protocol ATQMeCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;
@end
@interface ATQMeTableViewCell : UITableViewCell
@property (nonatomic,weak)id <ATQMeCellDelegate>delegate;
@property (nonatomic,strong)ATQOperationView *operationView;
- (void)configCellWithModel:(ATQPYQModel *)model indexPath:(NSIndexPath *)indexPath;
@end
