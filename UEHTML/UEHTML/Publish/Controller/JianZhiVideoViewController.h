//
//  JianZhiVideoViewController.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import <DZNSegmentedControl.h>
#import "JZVideoTableViewCell.h"
#import "KaiTongVideoViewController.h"
#import "JianZhiShenHeViewController.h"

@interface JianZhiVideoViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource,DZNSegmentedControlDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *yiKaiTongView;
@property (strong, nonatomic) IBOutlet UIView *weiKaiTongView;
@property (strong, nonatomic) IBOutlet UIView *segmentView;
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
@property (nonatomic, strong) DZNSegmentedControl *segmentControl;

@end
