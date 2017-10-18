//
//  ATQDTTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQPYQModel;

@protocol ATQDTTableViewCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;

@end
@interface ATQDTTableViewCell : UITableViewCell

@property (nonatomic,weak)id <ATQDTTableViewCellDelegate>delegate;
-(void)setModel:(ATQPYQModel *)model;
- (void)configCellWithModel:(ATQPYQModel *)model indexPath:(NSIndexPath *)indexPath;
@end
