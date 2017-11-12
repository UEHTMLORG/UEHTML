//
//  DetailSubPublishViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "DetailSubPublishViewController.h"

@interface DetailSubPublishViewController ()

@end

@implementation DetailSubPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职详情";
    [self settingTableView];
    /** iOS11.0 处理TableView ScrollView 留白问题 */
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark ===================关于TableView的所有方法 START==================
- (void)settingTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return 200.0f;
        }
            break;
        case 1:{
            return 135.0;
        }
            break;
        case 2:{
            return 150.0f;
        }
            break;
        case 3:{
            return 102.0f;
        }
            break;
        case 4:{
            return 120.0f;
        }
            break;
        case 5:{
            return 30.0f;
        }
            break;
        case 6:{
            return 83.0f;
        }
            break;
        default:
            return 40.0f;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            static NSString * rid = @"DetailXuQiuFirstCellID";
            DetailSubPublishCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][0];
            }
            [cell.leftBackButton addTarget:self action:@selector(leftBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            return cell;
        }
            break;
        case 1:{
            static NSString * rid = @"DetailXuQiuSecondCellID";
            DetailSubPublishSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][1];
            }
            
            return cell;
        }
            break;
        case 2:{
            static NSString * rid = @"DetailXuQiuThirdCellID";
            DetailSubPublishThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][2];
            }
            
            return cell;
        }
            break;
        case 3:{
            static NSString * rid = @"DetailXuQiuFourCellID";
            DetailSubPublishFourCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][3];
            }
            
            return cell;
        }
            break;
        case 4:{
            static NSString * rid = @"DetailXuQiuFiveCellID";
            DetailSubPublishFiveCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][4];
            }
            
            return cell;
        }
            break;
        case 5:{
            static NSString * rid = @"DetailXuQiuSixCellID";
            DetailSubPublishSixCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][5];
            }
            
            return cell;
        }
            break;
        case 6:{
            static NSString * rid = @"DetailXuQiuSevenCellID";
            DetailSubPublishSevenCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][6];
            }
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}
#pragma mark ===================关于TableView的所有方法 END==================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ===================底部按钮执行方法 START==================

- (IBAction)songLiBtnAction:(id)sender {
}
- (IBAction)shipinBtnAction:(id)sender {
}
- (IBAction)liaotianBtnAction:(id)sender {
}
- (IBAction)yueTaBtnAction:(id)sender {
}
#pragma mark ===================底部按钮执行方法 END==================
#pragma mark ===================懒加载==================
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}


/** 设置状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

/** 返回按钮实现 */
- (void)leftBackButtonAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
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
