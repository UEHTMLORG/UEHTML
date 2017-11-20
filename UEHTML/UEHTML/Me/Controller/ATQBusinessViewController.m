//
//  ATQBusinessViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBusinessViewController.h"
#import "ATQBusinessTableViewCell.h"
#import "ATQBillTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSDictionary *dataDic;

@end

@implementation ATQBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是代理商";
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/agent/data",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----agent=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            if (responseObject[@"data"]) {
                self.dataDic = responseObject[@"data"];
            }
            [self.tableView reloadData];
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            
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
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQBusinessTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQBillTableViewCell"];
        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ATQBusinessTableViewCell" ;
        ATQBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.zongshouruLab.text = self.dataDic[@"agent_income"];
        cell.dailiAreaLab.text = [NSString stringWithFormat:@"您所在的代理区域：%@",self.dataDic[@"area"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1){
        static NSString *CellIdentifier = @"ATQBillTableViewCell" ;
        ATQBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.backgroundColor = RGBA(236, 199, 114, 1);
        cell.typeLab.text = @"当日账单";
        cell.billImg.image = [UIImage imageNamed:@"zhanghu-daili"];
        cell.billSRLab.text = [NSString stringWithFormat:@"当日收入：%@元",self.dataDic[@"today_income"]];
        cell.billJYLab.text = [NSString stringWithFormat:@"当日交易量：%@单",self.dataDic[@"today_order_num"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
            static NSString *CellIdentifier = @"ATQBillTableViewCell" ;
            ATQBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.backgroundColor = RGBA(137, 188, 248, 1);
        cell.typeLab.text = @"当月账单";
            cell.billImg.image = [UIImage imageNamed:@"zhanghu-daili02"];
            cell.billSRLab.text = [NSString stringWithFormat:@"当月收入：%@元",self.dataDic[@"month_income"]];
            cell.billJYLab.text = [NSString stringWithFormat:@"当月交易量：%@单",self.dataDic[@"month_order_num"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else{
        return 90;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0;
    }else{
        return 5;
    }
}

-(NSDictionary*)dataDic{
    if (_dataDic == nil) {
        _dataDic = [NSDictionary dictionary];
    }
    return _dataDic;
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
