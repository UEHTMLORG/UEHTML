//
//  ATQSearchFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSearchFriendsViewController.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "ATQNewFriendsTableViewCell.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ATQAddFriListModel.h"
#import "UIImageView+WebCache.h"
@interface ATQSearchFriendsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField *searchText;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *searchArr;
@end

@implementation ATQSearchFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNaviView];
    [self setTableView];
    [self loadData:self.searchStr];
}

-(void)loadData:(NSString*)aotu_id{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"aotu_id"] = user_id;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/friend/search",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----search=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_searchArr removeAllObjects];
            if(responseObject[@"data"]){
                [self.tableView.mj_header endRefreshing];
                self.searchArr = [ATQAddFriListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.tableView reloadData];
            }
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

-(void)buildNaviView{
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBack)];
    
    self.navigationItem.rightBarButtonItem = right;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 30)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 4.f;
    mainView.layer.masksToBounds = YES;
    self.navigationItem.titleView = mainView;
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    searchImg.image = [UIImage imageNamed:@"haoyou-chazhao"];
    [mainView addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(20);
        make.left.equalTo(mainView.mas_left).offset(5);
        make.centerY.equalTo(mainView.mas_centerY);
    }];
    searchText = [[UITextField alloc]initWithFrame:CGRectZero];
    searchText.placeholder = @"请输入凹凸圈ID";
    searchText.text = self.searchStr;
    searchText.font = [UIFont systemFontOfSize:14];
    searchText.textColor = [UIColor colorWithHexString:@"959697"];
    searchText.tintColor = [UIColor blueColor];
    searchText.returnKeyType = UIReturnKeySearch;
    searchText.enablesReturnKeyAutomatically = YES;
    searchText.delegate = self;
    searchText.enabled = YES;
    [mainView addSubview:searchText];
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right).offset(5);
        make.top.bottom.equalTo(mainView);
    }];
    UIButton *chaBtn = [[UIButton  alloc] initWithFrame:CGRectZero];
    [chaBtn setImage:[UIImage imageNamed:@"haoyou-cha"] forState:UIControlStateNormal];
    [chaBtn addTarget:self action:@selector(qingchuClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:chaBtn];
    [chaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(15);
        make.left.equalTo(searchText.mas_right).offset(5);
        make.right.equalTo(mainView).offset(-5);
        make.centerY.equalTo(mainView.mas_centerY);
    }];
}

-(void)setTableView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQNewFriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQNewFriendsTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.sectionIndexColor = [UIColor blackColor];
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithHexString:UIColorStr];
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
    return self.searchArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQNewFriendsTableViewCell" ;
    ATQAddFriListModel *model = nil;
    if (_searchArr.count>0) {
        model = _searchArr[indexPath.row];
    }
    ATQNewFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    cell.userNameLab.text = model.nick_name;
    cell.ageLab.text = [NSString stringWithFormat:@"%@岁", model.age];
    if ([model.gender isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"zhuce-nan"];
    }else{
        cell.sexImg.image = [UIImage imageNamed:@"zhuce-nv"];
    }
    if ([model.status isEqualToString:@"1"]) {
        [cell.addBtn setTitle:@"已添加" forState:UIControlStateNormal];
        cell.addBtn.backgroundColor = [UIColor clearColor];
        [cell.addBtn setTitleColor:[UIColor colorWithHexString:UIDTTextColorStr] forState:UIControlStateNormal];
        cell.addBtn.enabled = NO;
    }else{
        [cell.addBtn setTitle:@"添加" forState:UIControlStateNormal];
        cell.addBtn.backgroundColor = [UIColor colorWithHexString:UIColorStr];
        [cell.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.addBtn.enabled = YES;
    }
    cell.addfriendsblock = ^{
        NSLog(@"add");
        [self addNewFriend:model.user_id];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)rightBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)qingchuClick{

    searchText.text = @"";
    [searchText becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"++++%@",textField.text);
    [self loadData:textField.text];
    [searchText resignFirstResponder];
    return YES;
}

-(void)addNewFriend:(NSString*)idstr{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"friend_user_id"] = idstr;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/friend/apply",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----apply=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
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

-(NSMutableArray*)searchArr{
    if (_searchArr == nil) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
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
