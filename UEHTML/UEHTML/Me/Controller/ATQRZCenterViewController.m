//
//  ATQRZCenterViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/5.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRZCenterViewController.h"
#import "ATQRZCenterTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "ATQYajinRZViewController.h"
#import "ATQSPRZViewController.h"
#import "ATQSFRZViewController.h"
#import "ATQCarRZViewController.h"
#import "ATQCarRZSuccessViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ZLSecondAFNetworking.h"
@interface ATQRZCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSDictionary *dic;

@end

@implementation ATQRZCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"认证中心";
    _dic = [NSDictionary dictionary];
    [self setTableView];
    [self loadData];
}
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQRZCenterTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQRZCenterTableViewCell"];
        
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_list",ATQBaseUrl];
  
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                NSDictionary *tempdic = [NSDictionary dictionary];
                tempdic = responseObject[@"data"];
                _dic = tempdic;
            }
            [self.tableView reloadData];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQRZCenterTableViewCell" ;
    ATQRZCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *phone_auth = _dic[@"phone_auth"];
    NSString *id_info_auth = _dic[@"id_info_auth"];
    NSString *video_auth = _dic[@"video_auth"];
    NSString *car_auth = _dic[@"car_auth"];
    NSString *avatar_auth = _dic[@"avatar_auth"];
    NSString *deposit_auth = _dic[@"deposit_auth"];
    if (indexPath.section == 0) {
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button02"];
        cell.typeLab.text = @"手机认证";
        cell.zengsongLab.text = @"送5金币";
        if (phone_auth != nil && [phone_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
        
    }else if (indexPath.section == 1){
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button03"];
        cell.typeLab.text = @"身份认证";
        cell.zengsongLab.text = @"送5金币";
        if (id_info_auth != nil && [id_info_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
        
    }else if (indexPath.section == 2){
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button04"];
        cell.typeLab.text = @"视频认证";
        cell.zengsongLab.text = @"送5金币";
        if (video_auth != nil && [video_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
       
    }else if (indexPath.section == 3){
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button05"];
        cell.typeLab.text = @"车辆认证";
        cell.zengsongLab.text = @"送5金币";
        if (car_auth != nil && [car_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
        
    }else if (indexPath.section == 4){
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button06"];
        cell.typeLab.text = @"个人头像认证";
        cell.zengsongLab.text = @"送5金币";
        if (avatar_auth != nil && [avatar_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
        
    }else{
        cell.typeImg.image = [UIImage imageNamed:@"renzheng-button07"];
        cell.typeLab.text = @"押金认证";
        cell.zengsongLab.text = @"送5金币";
        if (deposit_auth != nil && [deposit_auth isEqualToString:@"1"]) {
            cell.statusLab.text = @"已认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIColorStr];
        }else{
            cell.statusLab.text = @"未认证";
            cell.statusLab.textColor = [UIColor colorWithHexString:UIToneTextColorStr];
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        ATQSFRZViewController *vc = [[ATQSFRZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 2){
        ATQSPRZViewController *vc = [[ATQSPRZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 3){
        
        ATQCarRZViewController *vc = [[ATQCarRZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 4){
        
        
    }else{
        ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 2)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 2;
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
