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
#import "WoYaoZhuanViewModel.h"

@interface WoYaoZhuanViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, copy) NSString *currentTypeStr;
@property (nonatomic, strong) UIView *dateBackView;
@property (nonatomic, strong) UIDatePicker *datePickerFeiLvYou;
/** 年龄按钮数组 */
@property (nonatomic, strong) NSArray *ageBtnArr;
/** 性别数组 */
@property (nonatomic, strong) NSArray *sexBtnArr;
/** model 参数 */
@property (nonatomic, copy) NSString *startTimeFeiLV;
@property (nonatomic, copy) NSString *currentSexStr;
@property (nonatomic, copy) NSString *currentAgeStr;
@property (nonatomic, copy) NSString *allPriceNumStr;
@property (nonatomic, copy) NSString *currentAddressStr;
@property (nonatomic, copy) NSString *feiYongDanJiaStr;
@property (nonatomic, copy) NSString *shiChangStr;
@property (nonatomic, copy) NSString *shuomingStr;

/** 当前纬度 */
@property (nonatomic, copy) NSString *currentLat;
/** 当前经度 */
@property (nonatomic, copy) NSString *currentLog;

@end
