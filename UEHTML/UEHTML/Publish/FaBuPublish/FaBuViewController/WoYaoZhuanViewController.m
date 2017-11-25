//
//  WoYaoZhuanViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "WoYaoZhuanViewController.h"

@interface WoYaoZhuanViewController (){
     BOOL _isLvYou;
    
}

@end

@implementation WoYaoZhuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
    /** UITableView注册方法 */
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"FaBuFirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FaBuTableVIewCellID"];
    self.currentTypeStr = @"陪聊天";
    self.allPriceNumStr = @"";
    self.currentLog = @"120.519231";
    self.currentLat = @"31.285271";
}

#pragma mark ===================UITableView 代理方法实现 START==================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 180.0f;
    }
    else{
        return 598.0f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString * cellID = @"FaBuTableVIewCellID";
        FaBuFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        cell.block = ^(NSInteger index, NSString *currentType) {
            if ([currentType isEqualToString:@"旅游"]) {
                _isLvYou = YES;
                [tableView reloadData];
            }
            else{
                _isLvYou = NO;
                [tableView reloadData];
            }
            weakSelf.currentTypeStr = currentType;
        };
        
        return cell;
    }
    else{
        if (_isLvYou == NO) {
            static NSString * cellID = @"FaBuXuQiuCellID";
            __weak typeof(self) weakSelf = self;
            FaBuXuQiuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = (FaBuXuQiuTableViewCell *)[[NSBundle mainBundle]loadNibNamed:@"FaBuXuQiuTableViewCell" owner:self options:nil][0];
            }
            /** 服务地址 */
            [cell.fuWuDiZhiTextField xw_addObserverBlockForKeyPath:@"text" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
                weakSelf.currentAddressStr = newVal;
            }];
            /** 服务费用 */
            [cell.jinEField xw_addObserverBlockForKeyPath:@"text" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
                NSLog(@"服务单价:旧值%@---新值%@",oldVal,newVal);
                if ([ZhengZePanDuan checkShuZi:newVal] && [ZhengZePanDuan checkShuZi:cell.shiChangField.text]) {
                    cell.allPriceLabel.text = [NSString stringWithFormat:@"本单总金额：%d元",[newVal intValue]*[cell.shiChangField.text intValue]];
                    self.allPriceNumStr = [NSString stringWithFormat:@"%d",[newVal intValue]*[cell.shiChangField.text intValue]];
                    self.feiYongDanJiaStr = [NSString stringWithFormat:@"%d",[newVal intValue]];
                }
                
            }];
            /** 服务时长 */
            [cell.shiChangField xw_addObserverBlockForKeyPath:@"text" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
                NSLog(@"服务时长:旧值%@---新值%@",oldVal,newVal);
                if ([ZhengZePanDuan checkShuZi:newVal] && [ZhengZePanDuan checkShuZi:cell.jinEField.text]) {
                    cell.allPriceLabel.text = [NSString stringWithFormat:@"本单总金额：%d元",[newVal intValue]*[cell.jinEField.text intValue]];
                    self.allPriceNumStr = [NSString stringWithFormat:@"%d",[newVal intValue]*[cell.jinEField.text intValue]];
                    self.shiChangStr = [NSString stringWithFormat:@"%d",[newVal intValue]];
                }
            }];
            /** 需求说明 */
            cell.shuoMingField.delegate = self;
            [cell.timeButton addTarget:self action:@selector(startTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            /** 年龄按钮设置 */
            cell.age01Button.tag = 1;
            cell.age02Button.tag = 2;
            cell.age03Button.tag = 3;
            [cell.age01Button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.age02Button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.age03Button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            /** 性别按钮设置 */
            cell.sex01Button.tag = 1;
            cell.sex02button.tag = 2;
            cell.sexNOButton.tag = 3;
            [cell.sex01Button addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sex02button addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sexNOButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.sexBtnArr = cell.sexButtonArr;
            self.ageBtnArr = cell.ageButtonArr;
            
            
            
            cell.yaJinLabel.linkTextAttributes = @{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            [cell.tijiaoButton addTarget:self action:@selector(oKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else{
            static NSString * cellID = @"FaBuXuQiuCellIDLvYou";
            __weak typeof(self) weakSelf = self;
            FaBuXuQiuLvYouCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = (FaBuXuQiuLvYouCell *)[[NSBundle mainBundle]loadNibNamed:@"FaBuXuQiuTableViewCell" owner:self options:nil][1];
            }
            /** 按钮添加方法 */
            [cell.mudiButton addTarget:self action:@selector(mudidiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chuFaTimeButton addTarget:self action:@selector(chuFaTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.yujiTimeButton addTarget:self action:@selector(yuJiTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.chuXingButton addTarget:self action:@selector(chuXingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.priceButton addTarget:self action:@selector(peiTongFeiYongButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.priceButton.titleLabel xw_addObserverBlockForKeyPath:@"text" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
                cell.allPriceLabel.text = [NSString stringWithFormat:@"本单总金额：%@元",weakSelf.lvAllPriceStr];
            }];
            /** 年龄按钮设置 */
            cell.age01button.tag = 1;
            cell.age02Button.tag = 2;
            cell.age03Button.tag = 3;
            [cell.age01button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.age02Button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.age03Button addTarget:self action:@selector(ageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            /** 性别按钮设置 */
            cell.sexNanButton.tag = 1;
            cell.sexNvButton.tag = 2;
            cell.sexNOButton.tag = 3;
            [cell.sexNanButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sexNvButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.sexNOButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.lvSexBtnArr = cell.sexButtonArr;
            self.lvAgeBtnArr = cell.ageButtonArr;
            
            cell.yaJinLabel.linkTextAttributes =@{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            cell.shuoMingTextField.delegate = self;
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            [cell.tiJiaoButton addTarget:self action:@selector(oKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
    }
}
#pragma mark ===================UITableView 代理方法实现 END==================
#pragma mark ===================非旅游 设置 START==================
/** 开始时间 */
- (void)startTimeAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:nil minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        weakSelf.startTimeFeiLV = selectValue;
    }];
}

/** 年龄要求按钮 */
- (void)ageButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

/** 性别要求按钮 */
- (void)sexButtonAction:(UIButton *)sender{
    if (_isLvYou == YES) {
        //旅游
        //非旅游
        [self.lvSexBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * button = (UIButton *)obj;
            button.selected = NO;
        }];
        sender.selected = !sender.selected;
    }
    else{
        //非旅游
        [self.sexBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * button = (UIButton *)obj;
            button.selected = NO;
        }];
        sender.selected = !sender.selected;
    }

}

/** 提交按钮 */
- (void)oKButtonAction:(UIButton *)sender{
    [self.view endEditing:YES];
    if (_isLvYou == YES) {
        NSLog(@"旅游提交");
            __weak typeof(self) weakSelf = self;
            [self.lvSexBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIButton * button = (UIButton *)obj;
                if (button.isSelected == YES) {
                    switch (idx) {
                        case 0:{
                            weakSelf.lvCurrentSexStr = @"1";
                        }
                            break;
                        case 1:{
                            weakSelf.lvCurrentSexStr = @"2";
                        }
                            break;
                        case 2:{
                            weakSelf.lvCurrentSexStr = @"0";
                        }
                            break;
                        default:
                            break;
                    }
                }
            }];
            NSArray * ageArr = @[@"18-25岁",@"25-30岁",@"30岁以上"];
            NSMutableArray * ageMuteArr = [NSMutableArray new];
            for (int i = 0; i<self.lvAgeBtnArr.count; i++) {
                UIButton * btn = self.lvAgeBtnArr[i];
                if (btn.isSelected == YES) {
                    [ageMuteArr addObject:ageArr[i]];
                }
            }
            //NSString *string = [array componentsJoinedByString:@","];
            //NSArray *array = [string componentsSeparatedByString:@","];
            /** 数组转化为字符串 */
            self.lvCurrentAgeStr = [ageMuteArr componentsJoinedByString:@","];
            /** 条件判断 */
            if ([self isCanTiJiao] == YES) {
                sender.enabled  = NO;
                [[WoYaoZhuanViewModel shareInstance] startTiJiaoFeiLvYouAFWorkingWithClass_id:self.currentTypeStr
                                                                                  withAddress:self.lvMuDidiStr
                                                                                withIntroduce:self.lvShuoMingStr
                                                                                    withPrice:self.lvfeiYongStr
                                                                                     withTime:self.lvYuJiTimeStr
                                                                                withStartTime:self.lvChuFaTimeStr
                                                                                      withAge:self.lvCurrentAgeStr
                                                                                   withGender:self.lvCurrentSexStr
                                                                                      withLon:self.currentLog
                                                                                      withLat:self.currentLat
                                                                                 withTripType:self.lvChuXingType
                                                                                withBackBlock:^(BOOL success) {
                                                                                    sender.enabled  = YES;
                                                                                }];
            }
            else{
                [MBManager showBriefAlert:@"请完善信息"];
            }
    }
    else{
        NSLog(@"非旅游");
        __weak typeof(self) weakSelf = self;
        [self.sexBtnArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * button = (UIButton *)obj;
            if (button.isSelected == YES) {
                switch (idx) {
                    case 0:{
                        weakSelf.currentSexStr = @"1";
                    }
                        break;
                    case 1:{
                        weakSelf.currentSexStr = @"2";
                    }
                        break;
                    case 2:{
                        weakSelf.currentSexStr = @"0";
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
        NSArray * ageArr = @[@"18-25岁",@"25-30岁",@"30岁以上"];
        NSMutableArray * ageMuteArr = [NSMutableArray new];
        for (int i = 0; i<self.ageBtnArr.count; i++) {
            UIButton * btn = self.ageBtnArr[i];
            if (btn.isSelected == YES) {
                [ageMuteArr addObject:ageArr[i]];
            }
        }
        //NSString *string = [array componentsJoinedByString:@","];
        //NSArray *array = [string componentsSeparatedByString:@","];
        /** 数组转化为字符串 */
        self.currentAgeStr = [ageMuteArr componentsJoinedByString:@","];
        /** 条件判断 */
        if ([self isCanTiJiao] == YES) {
            sender.enabled  = NO;
            [[WoYaoZhuanViewModel shareInstance] startTiJiaoFeiLvYouAFWorkingWithClass_id:self.currentTypeStr
                                                                              withAddress:self.currentAddressStr
                                                                            withIntroduce:self.shuomingStr
                                                                                withPrice:self.feiYongDanJiaStr
                                                                                 withTime:self.shiChangStr
                                                                            withStartTime:self.startTimeFeiLV
                                                                                  withAge:self.currentAgeStr
                                                                               withGender:self.currentSexStr
                                                                                  withLon:self.currentLog
                                                                                  withLat:self.currentLat
                                                                             withTripType:@"非旅游"
                                                                            withBackBlock:^(BOOL success) {
                                                                                sender.enabled  = YES;
                
            }];
        }
        else{
            [MBManager showBriefAlert:@"请完善信息"];
        }
    }
}

/** 判断是否可以提交 */
- (BOOL)isCanTiJiao{
    if (_isLvYou == NO) {
        
        NSLog(@"当前类型：%@,服务地址：%@,单价：%@,时长：%@,开始时间:%@,服务说明:%@,当前年龄：%@,当前性别:%@",self.currentTypeStr,self.currentAddressStr,self.feiYongDanJiaStr,self.shiChangStr,self.startTimeFeiLV,self.shuomingStr,self.currentAgeStr,self.currentSexStr);
        if (self.currentTypeStr.length > 0 && self.currentAddressStr.length > 0 && self.feiYongDanJiaStr.length > 0 && self.shiChangStr.length > 0  && self.startTimeFeiLV.length > 0 && self.shuomingStr.length > 0 && self.currentAgeStr.length > 0 && self.currentSexStr.length > 0) {
            return YES;
        }
        else{
            return NO;
        }
    }
    else{
        if (self.currentTypeStr.length > 0 && self.lvMuDidiStr.length > 0 && self.lvChuFaTimeStr.length > 0 && self.lvYuJiTimeStr.length > 0  && self.lvChuXingType.length > 0 && self.lvfeiYongStr.length > 0 && self.lvShuoMingStr.length > 0 && self.lvCurrentAgeStr.length > 0 && self.lvCurrentSexStr.length > 0) {
            return YES;
        }
        else{
            return NO;
        }
    }
}

#pragma mark ===================非旅游 设置 END==================
#pragma mark ===================旅游 设置 START==================
/** 目的地设置 */
- (void)mudidiButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@9,@4,@0] isAutoSelect:YES resultBlock:^(NSArray *selectAddressArr) {
        NSString * address = [NSString stringWithFormat:@"%@%@%@",selectAddressArr[0],selectAddressArr[1],selectAddressArr[2]];
        [sender setTitle:address forState:UIControlStateNormal];
        weakSelf.lvMuDidiStr = address;
    }];
}

/** 出发时间设置 */
- (void)chuFaTimeButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    [BRDatePickerView showDatePickerWithTitle:@"出发时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:nil minDateStr:@"" maxDateStr:@"" isAutoSelect:YES resultBlock:^(NSString *selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        weakSelf.lvChuFaTimeStr = selectValue;
    }];
}

/** 预计时间 */
- (void)yuJiTimeButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSArray * arr = @[@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天",@"10天",@"20天",@"30天"];
    [BRStringPickerView showStringPickerWithTitle:@"预计时间" dataSource:arr defaultSelValue:@"1天" isAutoSelect:YES resultBlock:^(id selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        weakSelf.lvYuJiTimeStr = selectValue;
    }];

}

/** 出行方式 */
- (void)chuXingButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSArray * arr = @[@"自驾游",@"飞机",@"高铁",@"绿皮",@"大巴"];
    [BRStringPickerView showStringPickerWithTitle:@"出行方式" dataSource:arr defaultSelValue:@"飞机" isAutoSelect:YES resultBlock:^(id selectValue) {
        [sender setTitle:selectValue forState:UIControlStateNormal];
        weakSelf.lvChuXingType = selectValue;
    }];
}

/** 陪同费用 */
- (void)peiTongFeiYongButtonAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSArray * arr = @[@"50",@"80",@"100",@"150",@"200",@"300 ",@"500",@"2000"];
    [BRStringPickerView showStringPickerWithTitle:@"陪同费用" dataSource:arr defaultSelValue:@"100元" isAutoSelect:YES resultBlock:^(id selectValue) {
        NSString * strign = [NSString stringWithFormat:@"%@元",selectValue];
        [sender setTitle:strign
                forState:UIControlStateNormal];
        weakSelf.lvfeiYongStr = selectValue;
        weakSelf.lvAllPriceStr = selectValue;
    }];
    
}

#pragma mark ===================旅游 设置 END==================

#pragma mark ===================UITextView代理方法START==================
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 1) {
        //非旅游
        self.shuomingStr = textView.text;
    }else{
        //旅游
        self.lvShuoMingStr = textView.text;
    }
}

#pragma mark ===================UITextView代理方法END==================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
