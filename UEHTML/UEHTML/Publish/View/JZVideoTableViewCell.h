//
//  JZVideoTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZVideoCellModel.h"

@interface JZVideoTableViewCell : UITableViewCell

- (void)bindWithModel:(JZVideoCellModel *)model;

@end
