//
//  ATQMyWechatViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyWechatViewController.h"
#import "UIColor+LhkhColor.h"
#import "LhkhButton.h"
#import "UIView+LhkhExtension.h"
#import "ATQWechatView.h"
#import "ATQWechatTableViewCell.h"
#import "ATQAWechatTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQWechatModel.h"
@interface ATQMyWechatViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSInteger b;
}
@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) LhkhButton *selectedButton;
@property (weak, nonatomic) UIView *sliderView;
@property (nonatomic,strong)ATQWechatView *WeChatView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *wechatArr;
@end

@implementation ATQMyWechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTitlesView];
    [self buildWechatView];
    [self setTableView];
    [self loadMeWechatData];
}
-(void)setupTitlesView{
    //标题数组
    NSArray *titleArr = @[@"我的",@"谁查看我",@"已查看"];
    //标题栏设置
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    titlesView.width = self.view.width ;
    titlesView.height = 60;
    titlesView.y = 0;
    UIButton *backBtn = [[UIButton  alloc] initWithFrame:CGRectMake(10, 33, 13, 15)];
    [backBtn setImage:[UIImage imageNamed:@"back_more"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [titlesView addSubview:backBtn];
    [self.view addSubview:titlesView];
    
    self.titlesView = titlesView;
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor colorWithHexString:UISelTextColorStr];
    sliderView.height = 2;
    sliderView.tag = -1;
    sliderView.y = titlesView.height - sliderView.height -5;
    
    self.sliderView = sliderView;
    
    //设置上面的按钮
    NSInteger width = (titlesView.width - 80) / titleArr.count;
    NSInteger height = 40;
    for (NSInteger i=0; i<titleArr.count; i++) {
        LhkhButton *btn = [[LhkhButton alloc] init];
        btn.width = width;
        btn.height = height;
        btn.y = 20;
        btn.x = i * width +40;
        btn.tag = i;
        [btn setTitle: titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.sliderView.width = btn.titleLabel.width;
            self.sliderView.centerX = btn.centerX;
        }
    }
    [self.titlesView addSubview:sliderView];
}

-(void)buildWechatView{
    __weak typeof(self) weakself = self;
    _WeChatView = ({
        ATQWechatView *WechatView =[ATQWechatView wechatView];
        WechatView.frame = CGRectMake(0, 60, ScreenWidth, ScreenHeight);
        WechatView.searchblock = ^{
            NSLog(@"search");
        };
        WechatView.saveblock = ^{
            [weakself settingWechat];
        };
        WechatView;
        
    });
    [self.view addSubview:_WeChatView];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark 标题栏每个按钮的点击事件
-(void)titleClick:(LhkhButton *)button{
    b = button.tag;
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    NSLog(@"%@",self.selectedButton.titleLabel.text);
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.width = button.titleLabel.width;
        self.sliderView.centerX = button.centerX;
        if (button.tag == 0) {
            _WeChatView.hidden = NO;
            _tableView.hidden = YES;
        }else if (button.tag == 1){
            b = button.tag;
            _tableView.hidden = NO;
            _WeChatView.hidden = YES;
            [self loadData:[NSString stringWithFormat:@"%ld",button.tag]];

        }else{
            _tableView.hidden = NO;
            _WeChatView.hidden = YES;
            [self loadData:[NSString stringWithFormat:@"%ld",button.tag]];

        }
    }];
}

-(void)loadMeWechatData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = @"1.0.0";
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/wechat/info",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----wechat=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
       
            if(responseObject[@"data"] && [responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
                NSString *wechat_income = responseObject[@"data"][@"wechat_income"];
                _WeChatView.shouyiLab.text = wechat_income;
            }
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)loadData:(NSString *)typeStr{
    NSLog(@"typeStr-%@",typeStr);
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = typeStr;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = @"1.0.0";
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/wechat/see_list",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----wechatlist=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self.wechatArr removeAllObjects];
            if (responseObject[@"data"]) {
                self.wechatArr = [ATQWechatModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
            [self.tableView reloadData];
            
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)settingWechat{
    NSLog(@"settingWechat-%@",_WeChatView.wechatText.text);
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"wechat"] = _WeChatView.wechatText.text;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = @"1.0.0";
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/user/wechat/setting",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----setwechat=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
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
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQWechatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQWechatTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQAWechatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQAWechatTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    b = 1;
    self.tableView.hidden = YES;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(60);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _wechatArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ATQWechatModel *model = self.wechatArr[indexPath.row];
    if (b == 1) {
        static NSString *CellIdentifier = @"ATQWechatTableViewCell" ;
        ATQWechatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"1"]];
        cell.nameLab.text = model.nick_name;
        cell.statusLab.text = model.is_friend;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQAWechatTableViewCell" ;
        ATQAWechatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"1"]];
        cell.nameLab.text = model.nick_name;
        cell.wechatLab.text = [NSString stringWithFormat:@"微信号：%@",model.wechat];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSMutableArray*)wechatArr{
    if (_wechatArr == nil) {
        _wechatArr = [NSMutableArray array];
    }
    return _wechatArr;
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
