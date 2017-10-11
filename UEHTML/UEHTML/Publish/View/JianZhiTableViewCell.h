//
//  JianZhiTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianZhiListCellModel.h"

@interface JianZhiTableViewCell : UITableViewCell


- (void)bindModel:(JianZhiListCellModel *)model;

@end
