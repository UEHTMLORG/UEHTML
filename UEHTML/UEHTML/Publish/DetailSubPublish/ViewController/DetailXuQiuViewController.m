//
//  DetailXuQiuViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "DetailXuQiuViewController.h"

@interface DetailXuQiuViewController ()

@end

@implementation DetailXuQiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"需求详情";
    [self settingTableView];
    /** 开始请求数据并绑定数据 */
    self.viewModel =  [DetailXuQiuViewModel shareInstance];
    __weak typeof(self) weakself = self;
    [self.viewModel startAFNetWorkingGetListWithJobID:self.jobId withController:self resultSuccessBlock:^(BOOL success, DetailXuQiuModel *model) {
        weakself.currentModel = model;
        [weakself.tabeView reloadData];
    } withFailBlock:^(NSError *error) {
        
    }];
}

#pragma mark ===================关于TableView的所有方法 START==================
- (void)settingTableView{
    self.tabeView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return 90.0f;
        }
            break;
        case 1:{
            return 40.0f;
        }
            break;
        case 2:{
            return 40.0f;
        }
            break;
        case 3:{
            return 100.0f;
        }
            break;
        case 4:{
            return 100.0f;
        }
            break;
        case 5:{
            return 100.0f;
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
            static NSString * rid = @"JianZhiDetailFirstCellID";
            DetailXuQiuViewCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailXuQiuViewCellTableViewCell" owner:self options:nil][0];
            }
            [cell.avatarImage sd_setImageWithURL:[NSURL URLWithString:self.currentModel.user_profile.avatar] placeholderImage:[UIImage imageNamed:DEFAULT_HEADIMAGE]];
            cell.nicknameLabel.text = self.currentModel.user_profile.nick_name;
            cell.chengLabel.text = self.currentModel.user_profile.credit_num;
            cell.juliLabel.text = self.currentModel.distance;
            
            return cell;
        }
            break;
        case 1:{
            static NSString * rid = @"JianZhiDetailSecondCellID";
            DetailXuQiuViewJobNameCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailXuQiuViewCellTableViewCell" owner:self options:nil][1];
            }
            
            return cell;
        }
            break;
        case 2:{
            static NSString * rid = @"JianZhiDetailThirdCellID";
            DetailXuQiuViewJobTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailXuQiuViewCellTableViewCell" owner:self options:nil][2];
            }
            
            return cell;
        }
            break;
        case 3:{
            static NSString * rid = @"DetailXuQiuThirdCellID";
            DetailSubPublishThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][2];
            }
            
            return cell;
        }
            break;
        case 4:{
            static NSString * rid = @"DetailXuQiuThirdCellID";
            DetailSubPublishThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][2];
            }
            
            return cell;
        }
            break;
        case 5:{
            static NSString * rid = @"DetailXuQiuThirdCellID";
            DetailSubPublishThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][2];
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

#pragma mark ===================底部按钮执行方法==================

- (IBAction)liaoTianButtonAction:(id)sender {
}
- (IBAction)yingYaoButtonAction:(id)sender {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ===================懒加载==================
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
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
