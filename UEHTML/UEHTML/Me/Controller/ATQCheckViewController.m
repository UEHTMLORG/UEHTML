//
//  ATQCheckViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQCheckViewController.h"
#import "ATQCheckTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQBillModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
@interface ATQCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *BillArr;
@property(strong,nonatomic)NSDictionary *secDic;
@property(strong,nonatomic)NSMutableArray *secArr;

@end

@implementation ATQCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账单";
    [self setTableView];
    [self loadData];
}

- (void)loadData{
    
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/account/bill",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----bill=%@",responseObject);
        [self.BillArr removeAllObjects];
        [self.secArr removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                self.secDic = responseObject[@"data"];
                NSArray *arr = responseObject[@"data"];
                for (NSString *secStr in arr) {
                    [self.secArr addObject:secStr];
                    NSArray *tempArr = [ATQBillModel mj_objectArrayWithKeyValuesArray:self.secDic[secStr]];
                    [self.BillArr addObjectsFromArray:tempArr];
                }
            }
            [self.tableView reloadData];
            
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
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQCheckTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQCheckTableViewCell"];
        
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
    return self.secArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr =_secDic[_secArr[section]];
    return arr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQCheckTableViewCell" ;
    ATQCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    NSArray *arr = _secDic[_secArr[indexPath.section]];
    NSArray *tempArr = [ATQBillModel mj_objectArrayWithKeyValuesArray:arr];
    ATQBillModel *model = tempArr[indexPath.row];
    if ([model.payment_code isEqualToString:@"gold"]) {
        cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan"];
        cell.leibieName.text = @"凹凸";
    }else if ([model.payment_code isEqualToString:@"weixin"]){
        cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan02"];
        cell.leibieName.text = @"微信";
    }else if ([model.payment_code isEqualToString:@"alipay"]){
        cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan03"];
        cell.leibieName.text = @"支付宝";
    }
    
    cell.timeLab.text = model.create_time;
    cell.moneyLab.text = model.price;
    cell.tagLab.text = model.source_remark;
    cell.statusLab.text = @"已到账";
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, view.frame.size.width-20, 30)];
    label.text = self.secArr[section];
    label.textColor = [UIColor colorWithHexString:@"C1C2C3"];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(NSMutableArray *)BillArr{
    if (_BillArr == nil) {
        _BillArr = [[NSMutableArray alloc] init];
    }
    return _BillArr;
}

-(NSMutableArray *)secArr{
    if (_secArr == nil) {
        _secArr = [[NSMutableArray alloc] init];
    }
    return _secArr;
}

-(NSDictionary*)secDic{
    if (_secDic == nil) {
        _secDic = [NSDictionary dictionary];
    }
    return _secDic;
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
