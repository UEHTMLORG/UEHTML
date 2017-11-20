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
#import "DetailXuQiuViewModel.h"


@interface DetailXuQiuViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *jobId;
@property (strong, nonatomic) IBOutlet UITableView *tabeView;

@property (nonatomic, strong) NSMutableArray  *modelArray;
@property (nonatomic, strong) DetailXuQiuViewModel *viewModel;
@property (nonatomic, strong) DetailXuQiuModel *currentModel;

@end
