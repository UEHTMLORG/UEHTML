//
//  WoYaoZhuanViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "FaBuFirstTableViewCell.h"
#import "FaBuXuQiuTableViewCell.h"
#import "ATQYajinRZViewController.h"


@interface WoYaoZhuanViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, copy) NSString *currentTypeStr;
@property (nonatomic, strong) UIView *dateBackView;
@property (nonatomic, strong) UIDatePicker *datePickerFeiLvYou;

@end
