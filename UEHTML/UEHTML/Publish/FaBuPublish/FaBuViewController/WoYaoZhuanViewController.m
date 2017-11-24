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
    [self setUpDateView];
}
/** 设置时间Picker */
- (void)setUpDateView{
    /** 开始时间Picker 非旅游 */
    self.dateBackView = [UIView new];
    self.dateBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dateBackView];
    [self.dateBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    UIButton * oKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [oKButton setTitle:@"确定" forState:UIControlStateNormal];
    [oKButton addTarget:self action:@selector(oKButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateBackView addSubview:oKButton];
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero]; //initWithFrame:CGRectMake(0,SIZE_HEIGHT-216,SIZE_WIDTH,216)];
    [self.view addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(216);
        make.top.mas_equalTo(self.view.mas_bottom).mas_offset(-216.0);
    }];
    
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
            FaBuXuQiuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = (FaBuXuQiuTableViewCell *)[[NSBundle mainBundle]loadNibNamed:@"FaBuXuQiuTableViewCell" owner:self options:nil][0];
            }
            [cell.timeButton addTarget:self action:@selector(startTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.yaJinLabel.linkTextAttributes = @{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            __weak typeof(self) weakSelf = self;
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            /*
             NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
             NSRange strRange = {0,[str length]};
             [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
             [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
             */
            return cell;
        }else{
            static NSString * cellID = @"FaBuXuQiuCellIDLvYou";
            FaBuXuQiuLvYouCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell == nil) {
                cell = (FaBuXuQiuLvYouCell *)[[NSBundle mainBundle]loadNibNamed:@"FaBuXuQiuTableViewCell" owner:self options:nil][1];
            }
            
            cell.yaJinLabel.linkTextAttributes =@{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            __weak typeof(self) weakSelf = self;
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            /*
             NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
             NSRange strRange = {0,[str length]};
             [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
             [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
             */
            return cell;
        }
        
    }
}
#pragma mark ===================UITableView 代理方法实现 END==================
#pragma mark ===================非旅游 设置 START==================
/** 开始时间 */
- (void)startTimeAction:(UIButton *)sender{
    
}
- (void)oKButtonAction:(UIButton *)sender{
    
}
#pragma mark ===================非旅游 设置 END==================
#pragma mark ===================旅游 设置 START==================

#pragma mark ===================旅游 设置 END==================


/** 按钮提交审核 */
- (void)tijiaoShenHeButtonAction:(UIButton *)sender{
    if (_isLvYou == YES) {
        /** 旅游 */
    }
    else{
        /** 非旅游 */
        
    }
}



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
