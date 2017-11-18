//
//  ZhaoRenFuWuViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "FaBuFirstTableViewCell.h"
#import "FaBuJianZhiTableViewCell.h"

@interface ZhaoRenFuWuViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end
