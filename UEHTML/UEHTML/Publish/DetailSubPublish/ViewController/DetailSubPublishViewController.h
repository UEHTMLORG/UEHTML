//
//  DetailSubPublishViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "DetailSubPublishCell.h"
#import "DetailXuQiuViewCellTableViewCell.h"
#import "DetailSubPublishViewModel.h"
#import "ZJImageViewBrowser.h"
#import <AVFoundation/AVFoundation.h>

@interface DetailSubPublishViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray  *modelArray;
@property (nonatomic, strong) NSString *jobId;
@property (nonatomic, strong) DetailSubPublishViewModel *viewModel;
@property (nonatomic, strong) DetailSubPublishModel *currentModel;
@end
