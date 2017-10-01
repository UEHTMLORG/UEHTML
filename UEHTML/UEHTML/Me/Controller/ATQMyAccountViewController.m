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
@interface ATQMyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;
@end

@implementation ATQMyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的账户";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"我的账单" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
    right.tintColor = [UIColor colorWithHexString:UISelTextColorStr];
    self.navigationItem.rightBarButtonItem = right;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.jinbiblock = ^{
            ATQBuyJinbiViewController *vc = [[ATQBuyJinbiViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.liwublock = ^{
            ATQMyliftViewController *vc = [[ATQMyliftViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        cell.vipblock = ^{
            ATQBuyVipViewController *vc = [[ATQBuyVipViewController alloc] init];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQAccountThiTableViewCell" ;
        ATQAccountThiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQAccountFourTableViewCell" ;
        ATQAccountFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
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
