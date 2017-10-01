//
//  ATQBuyJinbiViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBuyJinbiViewController.h"
#import "ATQBuyVipViewController.h"
#import "ATQBuyjbSecTableViewCell.h"
#import "ATQBuyjbFirTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"

@interface ATQBuyJinbiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQBuyJinbiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购买金币";
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQBuyjbFirTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQBuyjbFirTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQBuyjbSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQBuyjbSecTableViewCell"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"ATQBuyjbFirTableViewCell" ;
        ATQBuyjbFirTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.chongzhiVipblock = ^{
            ATQBuyVipViewController *vc = [[ATQBuyVipViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQBuyjbSecTableViewCell" ;
        ATQBuyjbSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.zengsongLab.hidden = YES;
        }else if (indexPath.row == 1){
            cell.jinbiLab.text = @"3000金币";
            cell.typeImg.image = [UIImage imageNamed:@"zhuanghu-goumai04"];
            cell.zengsongLab.hidden = NO;
            cell.zengsongLab.text = @"再送200金币，价值2元";
            
            [cell.jiageBtn setTitle:@"￥30" forState:UIControlStateNormal];
        }else if (indexPath.row == 2){
            cell.jinbiLab.text = @"6000金币";
            cell.typeImg.image = [UIImage imageNamed:@"zhuanghu-goumai03"];
            cell.zengsongLab.hidden = NO;
            cell.zengsongLab.text = @"再送500金币，价值5元";
            [cell.jiageBtn setTitle:@"￥50" forState:UIControlStateNormal];
        }else if (indexPath.row == 3){
            cell.jinbiLab.text = @"10800金币";
            cell.typeImg.image = [UIImage imageNamed:@"zhuanghu-goumai02"];
            cell.zengsongLab.hidden = NO;
            cell.zengsongLab.text = @"再送1200金币，价值12元";
            [cell.jiageBtn setTitle:@"￥108" forState:UIControlStateNormal];
        }else{
            cell.jinbiLab.text = @"21800金币";
            cell.typeImg.image = [UIImage imageNamed:@"zhuanghu-goumai"];
            cell.zengsongLab.hidden = NO;
            cell.zengsongLab.text = @"再送3000金币，价值30元";
            cell.zengsongLab.textColor = [UIColor colorWithHexString:UIColorStr];
            [cell.jiageBtn setTitle:@"￥218" forState:UIControlStateNormal];
        }
        cell.buyblock = ^{
            NSLog(@"点击了购买金币");
        };
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 65;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 15;
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
