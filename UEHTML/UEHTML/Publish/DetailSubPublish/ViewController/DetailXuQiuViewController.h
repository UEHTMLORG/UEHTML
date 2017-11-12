//
//  DetailXuQiuViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "DetailSubPublishCell.h"
#import "DetailXuQiuViewCellTableViewCell.h"


@interface DetailXuQiuViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tabeView;

@property (nonatomic, strong) NSMutableArray  *modelArray;


@end
