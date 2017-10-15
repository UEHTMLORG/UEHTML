//
//  JianZhiListTableVIew.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianZhiTableViewCell.h"
#import "JianZhiListCellModel.h"
#import "TiGongTableViewCell.h"
typedef NS_ENUM(NSUInteger, JianZhiCenterCellType) {
    JIANZHICELLTYPE,
    TIGONGCELLTYPE,
};

@interface JianZhiListTableVIew : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *tableARR;
@property (nonatomic, assign) JianZhiCenterCellType currentCellType;

- (void)loadTableViewWith:(NSMutableArray *)arrary withCellType:(JianZhiCenterCellType)type;
- (void)reloadTableViewWith:(NSMutableArray *)arrary withCellType:(JianZhiCenterCellType)type;

@end