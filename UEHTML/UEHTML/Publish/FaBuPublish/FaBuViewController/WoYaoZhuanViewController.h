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

@interface WoYaoZhuanViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

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

/** 旅游需要参数 */
/** 目的地 */
@property (nonatomic, copy) NSString *lvMuDidiStr;
/** 出发时间 */
@property (nonatomic, copy) NSString *lvChuFaTimeStr;
/** 预计时间 */
@property (nonatomic, copy) NSString *lvYuJiTimeStr;
/** 出行方式 */
@property (nonatomic, copy) NSString *lvChuXingType;
/** 陪同费用 */
@property (nonatomic, copy) NSString *lvfeiYongStr;
/** 需求说明 */
@property (nonatomic, copy) NSString *lvShuoMingStr;
/** 年龄要求 */
@property (nonatomic, copy) NSString *lvNianLingStr;
/** 总价格 */
@property (nonatomic, copy) NSString *lvAllPriceStr;
/** 年龄按钮数组 */
@property (nonatomic, strong) NSArray *lvAgeBtnArr;
/** 性别数组 */
@property (nonatomic, strong) NSArray *lvSexBtnArr;
@property (nonatomic, copy) NSString *lvCurrentSexStr;
@property (nonatomic, copy) NSString *lvCurrentAgeStr;


@end
