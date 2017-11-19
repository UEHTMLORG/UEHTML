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
#import "ZLLuYinManager.h"
#import <AVFoundation/AVFoundation.h>

@interface ZhaoRenFuWuViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;


@end
