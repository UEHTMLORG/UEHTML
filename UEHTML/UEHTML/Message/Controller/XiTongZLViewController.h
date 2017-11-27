//
//  XiTongZLViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "XiTongMsgTableViewCell.h"

@interface XiTongZLViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *array;
@end
