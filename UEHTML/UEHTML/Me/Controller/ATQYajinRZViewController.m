//
//  ATQYajinRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQYajinRZViewController.h"
#import "ATQYJRZTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQYJBuyViewController.h"
@interface ATQYajinRZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *yajinArr;

@end

@implementation ATQYajinRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"押金认证";
    self.view.backgroundColor = [UIColor whiteColor];
    _yajinArr = [NSMutableArray array];
    [self setTableView];
    [self loadData];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_deposit/price_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----price_list=%@",responseObject);
        [_yajinArr removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
           
            if(responseObject[@"data"]){
                NSArray *arr = responseObject[@"data"];
                [_yajinArr addObjectsFromArray:arr];
                [self.tableView reloadData];
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQYJRZTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQYJRZTableViewCell"];
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
    return _yajinArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQYJRZTableViewCell" ;
    ATQYJRZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_yajinArr.count>0) {
        NSDictionary *dic = _yajinArr[indexPath.row];
        NSString *price = dic[@"price"];
        if (indexPath.row == 0) {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.f",price.floatValue];
        }else if (indexPath.row == 1) {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin02"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.0f",price.floatValue];
        }else if (indexPath.row == 2) {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin03"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.0f",price.floatValue];
        }else if (indexPath.row == 3) {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin04"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.0f",price.floatValue];
        }else if (indexPath.row == 4) {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin05"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.0f",price.floatValue];
        }else {
            cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin06"];
            cell.lvLab.text = dic[@"title"];
            cell.lvMoney.text = [NSString stringWithFormat:@"￥%.0f",price.floatValue];
        }
    }
    __weak typeof(self) weakself = self;
    cell.renzhengblock = ^{
        NSLog(@"认证%ld",indexPath.row);
        ATQYJBuyViewController *vc = [[ATQYJBuyViewController alloc] init];
        NSDictionary *dic = _yajinArr[indexPath.row];
        NSString *str = dic[@"price"];
        NSString *price = [NSString stringWithFormat:@"%.f",str.floatValue];
        vc.yajinStr = price;
        [weakself.navigationController pushViewController:vc animated:NO];
    };
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
