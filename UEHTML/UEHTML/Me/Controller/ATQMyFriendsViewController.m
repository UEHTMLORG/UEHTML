//
//  ATQMyFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyFriendsViewController.h"
#import "LhkhButton.h"
#import "UIColor+LhkhColor.h"
#import "UIView+LhkhExtension.h"
#import "Masonry.h"
#import "ATQMyFriendsTableViewCell.h"
#import "ATQAddFriendsViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ATQFriModel.h"
#import "UIImageView+WebCache.h"
@interface ATQMyFriendsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSInteger b;
    NSString *typeStr;
}
@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) LhkhButton *selectedButton;
@property (weak, nonatomic) UIView *sliderView;
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *secArr;
@property (strong,nonatomic)NSDictionary *secDic;
@property (strong,nonatomic)NSMutableArray *friArr;
@end

@implementation ATQMyFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友345";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"haoyou-Top tianjia"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriendClick)];
    self.navigationItem.rightBarButtonItem = right;
    typeStr = @"1";
    _secArr = [NSMutableArray array];
    _secDic = [NSDictionary dictionary];
    [self setupTitlesView];
    [self setTableView];
}

-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = typeStr;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/friend/friend_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----friend_list=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_secArr removeAllObjects];
            [_friArr removeAllObjects];
            if(responseObject[@"data"]){
                [self.tableView.mj_header endRefreshing];
                _secDic = responseObject[@"data"];
                NSArray *arr = responseObject[@"data"];
                for (NSString *secStr in arr) {
                    [_secArr addObject:secStr];
                    NSArray *tempArr = [ATQFriModel mj_objectArrayWithKeyValuesArray:_secDic[secStr]];
                    [self.friArr addObjectsFromArray:tempArr];
                }
                
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


-(void)addFriendClick{
    NSLog(@"---");
    ATQAddFriendsViewController *vc = [[ATQAddFriendsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupTitlesView{
    //标题数组
    NSArray *titleArr = @[@"好友",@"关注",@"粉丝"];
    //标题栏设置
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = ScreenWidth ;
    titlesView.height = 40;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    
    self.titlesView = titlesView;
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    sliderView.height = 2;
    sliderView.tag = -1;
    sliderView.y = titlesView.height - sliderView.height;
    
    self.sliderView = sliderView;
    
    //设置上面的按钮
    NSInteger width = titlesView.width  / titleArr.count;
    NSInteger height = 30;
    for (NSInteger i=0; i<titleArr.count; i++) {
        LhkhButton *btn = [[LhkhButton alloc] init];
        btn.width = width;
        btn.height = height;
        btn.y = 5;
        btn.x = i * width;
        btn.tag = i;
        [btn setTitle: titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.sliderView.width = btn.width;
            self.sliderView.centerX = btn.centerX;
        }
    }
    [self.titlesView addSubview:sliderView];
}

-(void)setTableView{
    b = 0;
   
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMyFriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMyFriendsTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.sectionIndexColor = [UIColor blackColor];
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//        tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithHexString:UIColorStr];
        
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

#pragma mark 标题栏每个按钮的点击事件
-(void)titleClick:(LhkhButton *)button{
    b = button.tag;
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    NSLog(@"%@",self.selectedButton.titleLabel.text);
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.width = button.width;
        self.sliderView.centerX = button.centerX;
        if (button.tag == 0) {
            typeStr = @"1";
        }else if (button.tag == 1){
            typeStr = @"2";
        }else{
            typeStr = @"3";
        }
        [self loadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _secArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr =_secDic[_secArr[section]];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQMyFriendsTableViewCell" ;
    ATQFriModel *model;
   
    if (_secArr.count>0) {
        NSArray *arr = _secDic[_secArr[indexPath.section]];
        NSArray *tempArr = [ATQFriModel mj_objectArrayWithKeyValuesArray:arr];
        model = tempArr[indexPath.row];
    }
    ATQMyFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    cell.userNameLab.text = model.nick_name;
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
    if (_secArr.count>0) {
        label.text = _secArr[section];
    }
    
    label.textColor = [UIColor colorWithHexString:UIColorStr];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

#pragma mark Delete
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//滑动时可以设置多个按钮
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                             if (_secArr.count>0) {
                                                                                 NSArray *arr = _secDic[_secArr[indexPath.section]];
                                                                                 NSArray *tempArr = [ATQFriModel mj_objectArrayWithKeyValuesArray:arr];
                                                                                 ATQFriModel *model = tempArr[indexPath.row];
                                                                                 [self deleteFri:model.user_id];
                                                                             }
                                                                             NSLog(@"收藏点击事件");
                                                                             
                                                                         }];
    rowAction.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    
    NSArray *arr = @[rowAction];
    return arr;
}

//显示每组标题索引↑↓

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

//    [_secArr insertObject:@"↑" atIndex:0];
//    [_secArr addObject:@"↓"];
    
    return _secArr;
}

//返回每个索引的内容

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _secArr[section];
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index{
    NSInteger count = 0;
   
    for (NSString *character in _secArr) {
        
        if ([[character uppercaseString] hasPrefix:title]) {
            return count;
        }
        count++;
        NSLog(@"---%@",character);
    }
    return  0;
}

-(void)deleteFri:(NSString*)delID{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"delete_user_id"] = delID;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/friend/delete",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----delete=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            [self loadData];
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

-(NSMutableArray*)friArr{
    if (_friArr == nil) {
        _friArr = [NSMutableArray array];
    }
    return _friArr;
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
