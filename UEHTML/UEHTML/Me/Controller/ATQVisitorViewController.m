//
//  ATQVisitorViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQVisitorViewController.h"
#import "ATQBuyVipViewController.h"
#import "ATQVisitorTableViewCell.h"
#import "YAScrollSegmentControl.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "LhkhHttpsManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"
#import "ATQVisitorModel.h"
@interface ATQVisitorViewController ()<YAScrollSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource>{
    YAScrollSegmentControl *titleView;
    UIView *blankView;
    NSString *typeStr ;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *seeVisitorArr;
@property (nonatomic,strong)NSMutableArray *VisitorArr;
@end

@implementation ATQVisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self buildTitleView];
    [self  buildBlankView];
    [self setTableView];
    typeStr = @"1";
    NSString *card_level = [[NSUserDefaults standardUserDefaults]objectForKey:CARD_LEVEL_AOTU_ZL];
    if ([card_level isEqualToString:@"0"]) {
        blankView.hidden = NO;
        self.tableView.hidden = YES;
    }else{
        blankView.hidden = YES;
        self.tableView.hidden = NO;
        [self loadData:@"1"];
    }
}

-(void)loadData:(NSString*)type{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = type;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/visit",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----visit=%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_VisitorArr removeAllObjects];
            [_seeVisitorArr removeAllObjects];
            if(responseObject[@"data"]){
                if ([type isEqualToString:@"1"]) {
                    self.VisitorArr = [ATQVisitorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                }else if([type isEqualToString:@"2"]){
                    self.seeVisitorArr =  [ATQVisitorModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                }
                [self.tableView reloadData];
            }
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)buildBlankView{
    blankView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blankView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:@"my-jiao"];
    [blankView addSubview:imageView];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectZero];
    lab1.text = @"对不起,您目前无权查看来访者";
    lab1.textColor = [UIColor colorWithHexString:UIColorStr];
    lab1.font = [UIFont systemFontOfSize:14];
    [blankView addSubview:lab1];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [blankView addSubview:view];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [btn addTarget:self action:@selector(gotoVip) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"立即开通会员" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor colorWithHexString:UIDeepTextColorStr] forState:UIControlStateNormal];
    [view addSubview:btn];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectZero];
    spaceView.backgroundColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [view addSubview:spaceView];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectZero];
    lab2.text = @",查看来访者";
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [view addSubview:lab2];
    
    [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blankView);
        make.top.equalTo(blankView.mas_top).offset(50);
        make.width.height.offset(120);
    }];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blankView);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.offset(30);
    }];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab1.mas_bottom).offset(5);
        make.left.equalTo(lab1.mas_left).offset(10);
        make.right.equalTo(lab1.mas_right).offset(-10);
        make.centerX.equalTo(blankView);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(view);
        make.right.equalTo(lab2.mas_left).offset(0);
    }];
    
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.equalTo(btn.mas_left);
        make.width.equalTo(btn.mas_width);
        make.bottom.equalTo(btn.mas_bottom).offset(-5);
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(view);
        make.left.equalTo(btn.mas_right).offset(0);
    }];
}

-(void)buildTitleView{
    titleView = [[YAScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-50, 40)];
    titleView.delegate = self;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tintColor = [UIColor clearColor];
    titleView.buttons = @[@"来访者",@"我看过的人"];
    [titleView setTitleColor:[UIColor colorWithHexString:@"FFE010"] forState:UIControlStateSelected];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleView.selectedIndex = 0;
    self.navigationItem.titleView = titleView;
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQVisitorTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQVisitorTableViewCell"];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([typeStr isEqualToString:@"1"]) {
        return self.VisitorArr.count;
    }else{
        return self.seeVisitorArr.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQVisitorTableViewCell" ;
    ATQVisitorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ATQVisitorModel *model = nil;
    if ([typeStr isEqualToString:@"1"]) {
        if (self.VisitorArr.count>0) {
            model = self.VisitorArr[indexPath.row];
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
            cell.userName.text = model.nick_name;
            if ([model.gender isEqualToString:@"0"]) {
                cell.sexImg.hidden = YES;
            }else if ([model.gender isEqualToString:@"1"]){
                cell.sexImg.hidden = NO;
                cell.sexImg.image = [UIImage imageNamed:@"my-sex02"];
            }else{
                cell.sexImg.hidden = NO;
                cell.sexImg.image = [UIImage imageNamed:@"my-sex"];
            }
            cell.ageLab.text = model.age;
            if ([model.card_level isEqualToString:@"0"]) {
                cell.vipImg.hidden = YES;
            }else{
                cell.vipImg.hidden = NO;
            }
        }
    }else{
        if (self.seeVisitorArr.count>0) {
            model = self.seeVisitorArr[indexPath.row];
            [cell.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
            cell.userName.text = model.nick_name;
            if ([model.gender isEqualToString:@"0"]) {
                cell.sexImg.hidden = YES;
            }else if ([model.gender isEqualToString:@"1"]){
                cell.sexImg.hidden = NO;
                cell.sexImg.image = [UIImage imageNamed:@"my-sex02"];
            }else{
                cell.sexImg.hidden = NO;
                cell.sexImg.image = [UIImage imageNamed:@"my-sex"];
            }
            cell.ageLab.text = model.age;
            if ([model.card_level isEqualToString:@"0"]) {
                cell.vipImg.hidden = YES;
            }else{
                cell.vipImg.hidden = NO;
            }
        }
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)gotoVip{
    NSLog(@"gotoVip");
    ATQBuyVipViewController *vc = [[ATQBuyVipViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)right{
    
}

#pragma mark- YAScrollSegmentControlDelegate
-(void)didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld",index);
    if (titleView.selectedIndex == index) {
        return;
    }else{
        if (index == 0) {
            NSLog(@"点击了来访者");
            typeStr = @"1";
            NSString *card_level = [[NSUserDefaults standardUserDefaults]objectForKey:CARD_LEVEL_AOTU_ZL];
            if ([card_level isEqualToString:@"0"]) {
                blankView.hidden = NO;
                self.tableView.hidden = YES;
            }else{
                blankView.hidden = YES;
                self.tableView.hidden = NO;
                [self loadData:@"1"];
            }
        }else{
            NSLog(@"点击了我看过的人");
            typeStr = @"2";
            blankView.hidden = YES;
            self.tableView.hidden = NO;
            [self loadData:@"2"];
        }
    }
}

-(NSMutableArray*)VisitorArr{
    if (_VisitorArr == nil) {
        _VisitorArr = [NSMutableArray array];
    }
    return _VisitorArr;
}

-(NSMutableArray*)seeVisitorArr{
    if (_seeVisitorArr == nil) {
        _seeVisitorArr = [NSMutableArray array];
    }
    return _seeVisitorArr;
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
