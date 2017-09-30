//
//  ATQCheckViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQCheckViewController.h"
#import "ATQCheckTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
@interface ATQCheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableView;

@end

@implementation ATQCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账单";
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQCheckTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQCheckTableViewCell"];
        
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
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQCheckTableViewCell" ;
    ATQCheckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan"];
            cell.leibieName.text = @"凹凸";
            cell.timeLab.text = @"08-05 19:00";
            cell.moneyLab.text = @"+1.00";
            cell.tagLab.text = @"认证奖励";
            cell.statusLab.text = @"已到账";
        }else if (indexPath.row == 1){
            cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan02"];
            cell.leibieName.text = @"微信";
            cell.timeLab.text = @"08-15 19:00";
            cell.moneyLab.text = @"+50.00";
            cell.tagLab.text = @"充值";
            cell.statusLab.text = @"交易成功";
        }else if (indexPath.row == 2){
            cell.leibieImg.image = [UIImage imageNamed:@"zhanghu-zhangdan03"];
            cell.leibieName.text = @"支付宝";
            cell.timeLab.text = @"08-25 19:00";
            cell.moneyLab.text = @"+500.00";
            cell.tagLab.text = @"充值";
            cell.statusLab.text = @"交易成功";
        }
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, view.frame.size.width-20, 30)];
    label.text = @"2017-08";
    label.textColor = [UIColor colorWithHexString:@"C1C2C3"];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
