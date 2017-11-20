//
//  ATQMyAccountViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyAccountViewController.h"
#import "ATQCheckViewController.h"
#import "ATQBuyVipViewController.h"
#import "ATQBuyJinbiViewController.h"
#import "ATQChongzhiViewController.h"
#import "ATQMyliftViewController.h"
#import "ATQAccountFirTableViewCell.h"
#import "ATQAccountSecTableViewCell.h"
#import "ATQAccountThiTableViewCell.h"
#import "ATQAccountFourTableViewCell.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQTixianViewController.h"
@interface ATQMyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSDictionary *accountDic;
@end

@implementation ATQMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"我的账单" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    right.tintColor = [UIColor colorWithHexString:UISelTextColorStr];
    self.navigationItem.rightBarButtonItem = right;
    [self loadData];
    [self setTableView];
    [self buildBottom];
}

-(void)buildBottom{
    UIButton *bottomBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    [bottomBtn setTitle:@"充值" forState:UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(chongzhiClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.left.right.bottom.equalTo(self.view);
    }];
}

-(void)rightClick{
    NSLog(@"点击了我的账单");
    ATQCheckViewController *vc = [ATQCheckViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)chongzhiClick{
    NSLog(@"点击了充值");
    ATQChongzhiViewController *vc = [ATQChongzhiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/account/info",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----account=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                self.accountDic = responseObject[@"data"];
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
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQAccountFirTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQAccountFirTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQAccountSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQAccountSecTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQAccountThiTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQAccountThiTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQAccountFourTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQAccountFourTableViewCell"];
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
        make.bottom.mas_equalTo(self.view).offset(-40);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ATQAccountFirTableViewCell" ;
        ATQAccountFirTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        NSString *jinbi = self.accountDic[@"balance"];
        cell.jinbiLab.text = [NSString stringWithFormat:@"金币:%.f",jinbi.floatValue];
        cell.liwuLab.text = [NSString stringWithFormat:@"我的礼物:%@",self.accountDic[@"gift_num"]];
        
        cell.vipblock = ^{
            if ([self.accountDic[@"card_level"] isEqualToString:@"0"]) {
                ATQBuyVipViewController *vc = [[ATQBuyVipViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                [MBProgressHUD show:@"您已经是会员了" view:self.view];
            }
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.jinbiblock = ^{
            ATQBuyJinbiViewController *vc = [[ATQBuyJinbiViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.liwublock = ^{
            ATQMyliftViewController *vc = [[ATQMyliftViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"ATQAccountSecTableViewCell" ;
        ATQAccountSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.huaLab.text =self.accountDic[@"flower_num"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQAccountThiTableViewCell" ;
        ATQAccountThiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.tixianblock = ^{
            ATQTixianViewController *vc = [[ATQTixianViewController alloc] init];
            vc.tixianJine = self.accountDic[@"can_withdraw_rmb"];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.zongLab.text = self.accountDic[@"balance_rmb"];
        cell.jinriLab.text = self.accountDic[@"today_income_rmb"];
        cell.dongjieLab.text = self.accountDic[@"frozen_rmb"];
        cell.tixianLab.text = self.accountDic[@"can_withdraw_rmb"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQAccountFourTableViewCell" ;
        ATQAccountFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.shouruLab.text = self.accountDic[@"income_rmb"];
        cell.tixianLab.text = self.accountDic[@"withdraw"];
        cell.chongzhiLab.text = self.accountDic[@"recharge"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 190;
    }else{
        return 60;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return nil;
    }else if(section == 3){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(section == 3){
        return 20;
    }else{
        return 10;
    }
}

-(NSDictionary*)accountDic{
    if (_accountDic == nil) {
        _accountDic = [NSDictionary dictionary];
    }
    return _accountDic;
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
