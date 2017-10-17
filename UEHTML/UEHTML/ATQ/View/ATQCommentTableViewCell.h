//
//  ATQCommentTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQCommentModel;
@interface ATQCommentTableViewCell : UITableViewCell
- (void)configCellWithModel:(ATQCommentModel *)model;
@end
