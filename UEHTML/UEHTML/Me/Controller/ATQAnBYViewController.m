//
//  ATQAnBYViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/20.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQAnBYViewController.h"
#import "ATQAnbyCell.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ATQABYModel.h"
@interface ATQAnBYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *abyArr;
@end
static  NSInteger page = 1;
@implementation ATQAnBYViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"我是安保员";
    [self setTableView];
}


#pragma mark - Layout SubViews




#pragma mark - System Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.abyArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQAnbyCell" ;
    ATQAnbyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    ATQABYModel *model = self.abyArr[indexPath.section];
    [cell.abyImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.abyLab.text = model.nick_name;
    cell.txLab.text = model.job_class_name;
    cell.ageLab.text = model.age;
    cell.timeLab.text = [NSString stringWithFormat:@"服务时间：%@",model.start_time];
    cell.addrLab.text = model.address;
    cell.disLab.text = model.distance;
    if ([model.phone_auth isEqualToString:@"1"]) {
        cell.phoneImg.hidden = NO;
    }else{
        cell.phoneImg.hidden = YES;
    }
    if ([model.id_info_auth isEqualToString:@"1"]) {
        cell.idcardImg.hidden = NO;
    }else{
        cell.idcardImg.hidden = YES;
    }
    if ([model.video_auth isEqualToString:@"1"]) {
        cell.vedioImg.hidden = NO;
    }else{
        cell.vedioImg.hidden = YES;
    }
    if ([model.car_auth isEqualToString:@"1"]) {
        cell.carImg.hidden = NO;
    }else{
        cell.carImg.hidden = YES;
    }
    if ([model.face_auth isEqualToString:@"1"]) {
        cell.carImg.hidden = NO;
    }else{
        cell.carImg.hidden = YES;
    }
    if ([model.gender isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"zhanghu-sex"];
    }else{
        cell.sexImg.image = [UIImage imageNamed:@"zhanghu-sex02"];
    }
    if ([model.safety_status isEqualToString:@"0"]) {
        cell.cancelBtn.hidden = NO;
        cell.sureBtn.hidden = NO;
        cell.outDataLab.hidden = YES;
    }else if ([model.safety_status isEqualToString:@"1"]){
        cell.cancelBtn.hidden = YES;
        cell.sureBtn.hidden = YES;
        cell.outDataLab.hidden = NO;
        cell.outDataLab.text = @"已保驾";
    }else{
        cell.cancelBtn.hidden = YES;
        cell.sureBtn.hidden = YES;
        cell.outDataLab.hidden = NO;
        cell.outDataLab.text = @"已取消";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        return [[UIView alloc]init];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0 ;
    }else{
        return 10;
    }
}

#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"page_index"] = @"1";
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/safety/data",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----safety=%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        [self.abyArr removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                self.abyArr = [ATQABYModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                }
                page++;
                [self.tableView reloadData];
            
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
}

-(MJRefreshAutoNormalFooter *)loadMoreDataFooterWith:(UIScrollView *)scrollView {
    MJRefreshAutoNormalFooter *loadMoreFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        page++;
    }];
    
    return loadMoreFooter;
}

-(void)loadMoreData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    NSString *pageindex = [NSString stringWithFormat:@"%ld",page];
    params[@"page_index"] = pageindex;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/safety/data",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----safety=%@",responseObject);
        [self.tableView.mj_footer endRefreshing];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                [self.abyArr addObjectsFromArray:[ATQABYModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
            [self.tableView reloadData];
            
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_footer endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_footer endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"%@",error);
    }];
}

#pragma mark - Public Methods




#pragma mark - Private Methods
-(void)setTableView{

    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQAnbyCell" bundle:nil] forCellReuseIdentifier:@"ATQAnbyCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}



#pragma mark - Getters and Setters

-(NSMutableArray*)abyArr{
    if (_abyArr == nil) {
        _abyArr = [NSMutableArray array];
    }
    return _abyArr;
}

@end

