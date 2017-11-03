//
//  ATQUserManualViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQUserManualViewController.h"
#import "ATQSZSecTableViewCell.h"
#import "Masonry.h"
#import "ATQUseNoteViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQUserManualViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *handbook_listArr;
@end

@implementation ATQUserManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"使用手册";
    _handbook_listArr = [NSMutableArray array];
    [self loadData];
    [self setTableView];
    
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/article/handbook_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----handbook_list=%@",responseObject);
        [_handbook_listArr removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
  
            if(responseObject[@"data"]){
                NSArray *arr = responseObject[@"data"];
                [_handbook_listArr addObjectsFromArray:arr];
                [self.tableView reloadData];
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZSecTableViewCell"];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _handbook_listArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
    ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *tempDic = nil;
    if (_handbook_listArr.count>0) {
        tempDic = _handbook_listArr[indexPath.row];
        cell.titleLab.text = tempDic[@"title"];
    }
    /*
    if (indexPath.row == 0) {
        cell.titleLab.text = @"凹凸圈使用协议";
    }else if (indexPath.row == 1){
        cell.titleLab.text = @"凹凸圈充值协议";
    }else if (indexPath.row == 2){
        cell.titleLab.text = @"凹凸圈服务保障";
    }else if (indexPath.row == 3){
        cell.titleLab.text = @"关于凹凸圈";
    }else if (indexPath.row == 4){
        cell.titleLab.text = @"积分规则";
    }else if (indexPath.row == 5){
        cell.titleLab.text = @"红包规则";
    }else if (indexPath.row == 6){
        cell.titleLab.text = @"赚钱攻略";
    }else if (indexPath.row == 7){
        cell.titleLab.text = @"常见问题";
    }else if (indexPath.row == 8){
        cell.titleLab.text = @"审核规范";
    }else if (indexPath.row == 9){
        cell.titleLab.text = @"凹凸圈用户行为规范";
    }else{
        cell.titleLab.text = @"订单提醒设置方法";
    }*/
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     ATQUseNoteViewController*vc = [[ATQUseNoteViewController alloc] init];
    NSDictionary *tempDic = nil;
    if (_handbook_listArr.count>0) {
        tempDic = _handbook_listArr[indexPath.row];
        vc.idStr = tempDic[@"id"];
        vc.navigationItem.title = tempDic[@"title"];
    }
    /*
    if (indexPath.row == 0) {
        vc.navigationItem.title = @"凹凸圈使用协议";
    }else if (indexPath.row == 1){
        vc.navigationItem.title = @"凹凸圈充值协议";
    }else if (indexPath.row == 2){
        vc.navigationItem.title = @"凹凸圈服务保障";
    }else if (indexPath.row == 3){
        vc.navigationItem.title = @"关于凹凸圈";
    }else if (indexPath.row == 4){
        vc.navigationItem.title = @"积分规则";
    }else if (indexPath.row == 5){
        vc.navigationItem.title = @"红包规则";
    }else if (indexPath.row == 6){
        vc.navigationItem.title = @"赚钱攻略";
    }else if (indexPath.row == 7){
        vc.navigationItem.title = @"常见问题";
    }else if (indexPath.row == 8){
        vc.navigationItem.title = @"审核规范";
    }else if (indexPath.row == 9){
        vc.navigationItem.title = @"凹凸圈用户行为规范";
    }else{
        vc.navigationItem.title = @"订单提醒设置方法";
    }*/
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
