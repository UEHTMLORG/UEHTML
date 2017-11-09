//
//  TiGongTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianZhiListCellModel.h"
#import "PublishZLViewModel.h"
@interface TiGongTableViewCell : UITableViewCell


@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;


- (void)bindWithMyModel:(FuWuFangMyListCellModel *)model;


@end


@interface FuWuFangTuiJianCell: UITableViewCell
@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;

- (void)bindWithTuiJianModel:(FuWuFangTuiJianCellModel *)model;

@end
