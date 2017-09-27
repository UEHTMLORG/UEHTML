//
//  ATQUserManualViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQUserManualViewController.h"
#import "ATQSZSecTableViewCell.h"
#import "Masonry.h"
#import "ATQUseNoteViewController.h"
@interface ATQUserManualViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQUserManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"使用手册";
    [self setTableView];
    
}
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZSecTableViewCell"];
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
    return 11;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
    ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.titleLab.text = @"凹凸圈使用协议";
    }else if (indexPath.row == 1){
        cell.titleLab.text = @"凹凸圈充值协议";
    }else if (indexPath.row == 2){
        cell.titleLab.text = @"凹凸圈服务保障";
    }else if (indexPath.row == 3){
        cell.titleLab.text = @"关于凹凸圈";
    }else if (indexPath.row == 4){
        cell.titleLab.text = @"积分规则";
    }else if (indexPath.row == 5){
        cell.titleLab.text = @"红包规则";
    }else if (indexPath.row == 6){
        cell.titleLab.text = @"赚钱攻略";
    }else if (indexPath.row == 7){
        cell.titleLab.text = @"常见问题";
    }else if (indexPath.row == 8){
        cell.titleLab.text = @"审核规范";
    }else if (indexPath.row == 9){
        cell.titleLab.text = @"凹凸圈用户行为规范";
    }else{
        cell.titleLab.text = @"订单提醒设置方法";
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     ATQUseNoteViewController*vc = [[ATQUseNoteViewController alloc] init];
    
    if (indexPath.row == 0) {
        vc.navigationItem.title = @"凹凸圈使用协议";
    }else if (indexPath.row == 1){
        vc.navigationItem.title = @"凹凸圈充值协议";
    }else if (indexPath.row == 2){
        vc.navigationItem.title = @"凹凸圈服务保障";
    }else if (indexPath.row == 3){
        vc.navigationItem.title = @"关于凹凸圈";
    }else if (indexPath.row == 4){
        vc.navigationItem.title = @"积分规则";
    }else if (indexPath.row == 5){
        vc.navigationItem.title = @"红包规则";
    }else if (indexPath.row == 6){
        vc.navigationItem.title = @"赚钱攻略";
    }else if (indexPath.row == 7){
        vc.navigationItem.title = @"常见问题";
    }else if (indexPath.row == 8){
        vc.navigationItem.title = @"审核规范";
    }else if (indexPath.row == 9){
        vc.navigationItem.title = @"凹凸圈用户行为规范";
    }else{
        vc.navigationItem.title = @"订单提醒设置方法";
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
