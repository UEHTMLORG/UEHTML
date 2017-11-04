//
//  ATQContentTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ATQContentModel;
@interface ATQContentTableViewCell : UITableViewCell
- (void)configCellWithModel:(ATQContentModel *)model;
@end

