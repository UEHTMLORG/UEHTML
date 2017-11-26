//
//  DetailShiPinPublishViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/26.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "DetailSubPublishCell.h"
#import "DetailXuQiuViewCellTableViewCell.h"
#import "DetailSubPublishViewModel.h"
#import "ZJImageViewBrowser.h"
#import <AVFoundation/AVFoundation.h>
@interface DetailShiPinPublishViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray  *modelArray;
@property (nonatomic, strong) NSString *jobId;
@property (nonatomic, strong) DetailSubPublishViewModel *viewModel;
@property (nonatomic, strong) DetailSubPublishModel *currentModel;

@end
