//
//  ATQAddFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAddFriendsViewController.h"
#import "ATQSearchFriendsViewController.h"
#import "ATQNewFriendsTableViewCell.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ATQAddFriListModel.h"
#import "UIImageView+WebCache.h"
@interface ATQAddFriendsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *NewFriArr;
@end

@implementation ATQAddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友";
    [self buildSousuoView];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/friend/new_friend_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----friend_list=%@",responseObject);
        [self.tableView.mj_header endRefreshing];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_NewFriArr removeAllObjects];
            if([responseObject[@"data"] isKindOfClass:[NSDictionary class]] && responseObject[@"data"][@"new_friend"] ){
                self.NewFriArr = [ATQAddFriListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"new_friend"]];
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

-(void)buildSousuoView{
    self.sousuoView.layer.cornerRadius = 4.f;
    self.sousuoView.layer.masksToBounds = YES;
    self.sousuoView.layer.borderWidth = 1.f;
    self.sousuoView.layer.borderColor = [UIColor colorWithHexString:UIBgColorStr].CGColor;
    self.sousuoText.returnKeyType = UIReturnKeySearch;
    self.sousuoText.enablesReturnKeyAutomatically = YES;
    self.sousuoText.delegate = self;
    self.sousuoText.enabled = YES;
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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(40);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"++++%@",textField.text);
    ATQSearchFriendsViewController *vc = [[ATQSearchFriendsViewController alloc] init];
    vc.searchStr = textField.text;
    [self.navigationController pushViewController:vc animated:YES];
    [self.sousuoText resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.NewFriArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQNewFriendsTableViewCell" ;
    ATQAddFriListModel *model = nil;
    if (_NewFriArr.count>0) {
        model = self.NewFriArr[indexPath.row];
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
    }else{
        [cell.addBtn setTitle:@"添加" forState:UIControlStateNormal];
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

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 30)];
    label.text = @"新的朋友";
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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


-(NSMutableArray*)NewFriArr{
    if (_NewFriArr == nil) {
        _NewFriArr = [NSMutableArray array];
    }
    return _NewFriArr;
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
