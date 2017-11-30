//
//  ATQJZTypeListViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQJZTypeListViewController.h"
#import "ATQJZTypeListTableViewCell.h"
#import "Masonry.h"
#import "UIButton+Lhkh.h"
#import "UIColor+LhkhColor.h"
#import "ATQTypePeoDetailViewController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQHomeItemListModel.h"
#import "ATQPaixuView.h"
#import "ATQShaixuanView.h"
#import "ATQlvyouDetailViewController.h"
#import "DetailSubPublishViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ATQJZTypeListViewController ()<UITableViewDelegate,UITableViewDataSource,ATQPaixuViewDelegate,ATQShaixuanViewDelegate>{
    NSString *_model;
    NSString *_paixuStr;
    NSString *_gender;
    NSString *_age;
    NSString *_height;
    NSString *_distance;
    AVPlayer * _avPlayer;
}
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *jobListArr;
@property (strong,nonatomic)ATQPaixuView *PaixuView;
@property (strong,nonatomic)ATQShaixuanView *ShaixuanView;

@end
static NSInteger page = 1;
@implementation ATQJZTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.paixuBtn changeImageAndTitle];
    [self.shaixuanBtn changeImageAndTitle];
    [self setTableView];
    [self buildPaixuView];
    [self buildShaixuanView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _avPlayer = nil;
}

-(void)buildPaixuView{
    _PaixuView = ({
        ATQPaixuView *PaixuView =[ATQPaixuView meHeadView];
        PaixuView.delegate = self;
        [self.view addSubview:PaixuView];
        [PaixuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(41);
            make.left.right.mas_equalTo(self.view);
            make.height.offset(120);
        }];
        PaixuView.hidden = YES;
        PaixuView;
    });
}

-(void)buildShaixuanView{
    _ShaixuanView = ({
        ATQShaixuanView *ShaixuanView =[ATQShaixuanView meHeadView];
        ShaixuanView.delegate = self;
        [self.view addSubview:ShaixuanView];
        [ShaixuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(41);
            make.left.right.mas_equalTo(self.view);
            make.height.offset(244);
        }];
        ShaixuanView.hidden = YES;
        
        ShaixuanView;
    });
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQJZTypeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQJZTypeListTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
        [self.tableView.mj_header beginRefreshing];
        self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(40);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(MJRefreshAutoNormalFooter *)loadMoreDataFooterWith:(UIScrollView *)scrollView {
    MJRefreshAutoNormalFooter *loadMoreFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self loadMoreDataWithmodel:_model sort:_paixuStr gender:_gender age:_age height:_height distance:_distance];
        [scrollView.mj_footer endRefreshing];
    }];
    
    return loadMoreFooter;
}

- (void)paixuViewClick:(NSInteger)senderTag{
    NSLog(@"---->%ld",senderTag);
    NSString *paixuStr = [NSString stringWithFormat:@"%ld",senderTag];
    _paixuStr = paixuStr;
    [self loadDataWithmodel:@"" sort:paixuStr gender:@"" age:@"" height:@"" distance:@""];
    self.PaixuView.hidden = YES;
}

- (void)shaixuanViewClick:(NSString *)sexString age:(NSString *)ageString height:(NSString *)heightString distence:(NSString *)disString gongqiu:(NSString *)gqString{
    NSLog(@"--->%@-->%@-->%@-->%@-->%@",sexString,ageString,heightString,disString,gqString);
    _model = gqString;
    _gender = sexString;
    _age = ageString;
    _height = heightString;
    _distance = disString;
    
    [self loadDataWithmodel:gqString sort:@"" gender:sexString age:ageString height:heightString distance:disString];
    self.ShaixuanView.hidden = YES;
}

- (IBAction)paixuClick:(id)sender {
    self.PaixuView.hidden = NO;
    self.ShaixuanView.hidden = YES;
}

- (IBAction)shaixuanClick:(id)sender {
    self.PaixuView.hidden = YES;
    self.ShaixuanView.hidden = NO;
}

-(void)loadData{
    
    [self loadDataWithmodel:@"" sort:@"" gender:@"" age:@"" height:@"" distance:@""];
}


-(void)loadDataWithmodel:(NSString*)model sort:(NSString*)sort gender:(NSString*)gender age:(NSString*)age height:(NSString *)height distance:(NSString*)distance{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = model?:@"";
    params[@"sort"] = sort?:@"";
    params[@"gender"] = gender?:@"";
    params[@"age"] = age?:@"";
    params[@"height"] = height?:@"";
    params[@"distance"] = distance?:@"";
    params[@"job_class_id"] = self.jobID;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/home/job_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----job_list=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self.jobListArr removeAllObjects];
            if(responseObject[@"data"]){
                self.jobListArr = [ATQHomeItemListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]] ;
            }
            page = 1;
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


-(void)loadMoreDataWithmodel:(NSString*)model sort:(NSString*)sort gender:(NSString*)gender age:(NSString*)age height:(NSString *)height distance:(NSString*)distance{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = model?:@"";
    params[@"sort"] = sort?:@"";
    params[@"gender"] = gender?:@"";
    params[@"age"] = age?:@"";
    params[@"height"] = height?:@"";
    params[@"distance"] = distance?:@"";
    params[@"job_class_id"] = self.jobID;
    params[@"page_index"] = [NSString stringWithFormat:@"%ld",page];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/home/job_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----job_list=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            if(responseObject[@"data"]){
                [self.jobListArr addObjectsFromArray:[ATQHomeItemListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.jobListArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    static NSString *CellIdentifier = @"ATQJZTypeListTableViewCell" ;
    ATQJZTypeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    ATQHomeItemListModel *model = self.jobListArr[indexPath.section];
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.userNameLab.text = model.nick_name;
    if ([model.gender isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"zhuce-nan"];
    }else{
        cell.sexImg.image = [UIImage imageNamed:@"zhuce-nv"];
    }
    if ([model.deposit_auth isEqualToString:@"0"]) {
        cell.rzImg.hidden = YES;
    }else{
        cell.rzImg.hidden = NO;
    }
    if ([model.card_level isEqualToString:@"0"]) {
        cell.vipImg.hidden = YES;
        cell.shipingImg.hidden = YES;
    }else{
        cell.vipImg.hidden = NO;
        cell.shipingImg.hidden = NO;
    }
    NSString *texingStr = [NSString stringWithFormat:@"%@岁 %@cm %@kg",model.age,model.height,model.weight];
    cell.texingLab.text = texingStr;
    cell.disLab.text = model.distance;
    cell.chengLab.text = model.credit_num;
    cell.audioblock = ^{
        NSLog(@"audio");
        [weakself vedioClick:model.voice];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)vedioClick:(NSString*)voiceStr{
    NSURL * url = [NSURL URLWithString:voiceStr];
    _avPlayer = [[AVPlayer alloc] initWithURL:url];
    [_avPlayer play];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.jobID isEqualToString:@"7"]) {
        ATQlvyouDetailViewController *vc = [[ATQlvyouDetailViewController alloc] init];
        ATQHomeItemListModel *model = self.jobListArr[indexPath.section];
        vc.jobID = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        DetailSubPublishViewController *vc = [[DetailSubPublishViewController alloc] init];
        ATQHomeItemListModel *model = self.jobListArr[indexPath.section];
        vc.jobId = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
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
        return 5;
    }else{
        return 10;
    }
}

-(NSMutableArray *)jobListArr{
    if (_jobListArr == nil) {
        _jobListArr = [NSMutableArray array];
    }
    return _jobListArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
