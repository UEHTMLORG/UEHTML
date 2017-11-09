//
//  ATQSetupViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSetupViewController.h"
#import "ATQSZFirTableViewCell.h"
#import "ATQSZSecTableViewCell.h"
#import "ATQSZThiTableViewCell.h"
#import "ATQSZFourTableViewCell.h"
#import "ATQSZLoginOutTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIColor+LhkhColor.h"
#import "ATQSetupSecrityViewController.h"
#import "ATQUserManualViewController.h"
#import "ATQBlackListViewController.h"
#import "ATQOpinionViewController.h"
#import "ATQAboutAQTViewController.h"
#import "ATQUserInfoViewController.h"
#import "AppDelegate.h"

@interface ATQSetupViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    BOOL isClear;
    
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    
    [self setTableView];
}
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZFirTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZFirTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZSecTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZThiTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZThiTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZFourTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZFourTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZLoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZLoginOutTableViewCell"];
        
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
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else if (section == 2){
        return 2;
    }else if(section == 3){
        return 4;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"ATQSZFirTableViewCell" ;
            ATQSZFirTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.userImg sd_setImageWithURL:[NSURL URLWithString:_dic[@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];
        cell.userName.text = _dic[@"nick_name"];
            return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
            ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"设置支付密码";
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQSZThiTableViewCell" ;
            ATQSZThiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"设置无痕浏览";
            return cell;
        }
    }else if(indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
        ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"使用手册";
        }else{
            cell.titleLab.text = @"意见反馈";
        }
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 1 || indexPath.row == 3) {
            static NSString *CellIdentifier = @"ATQSZFourTableViewCell" ;
            ATQSZFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.titleLab.text = @"清除缓存";
                if (isClear == YES) {
                    cell.cacheLab.text = @"";
                }else{
                    cell.cacheLab.text = @"5.0M";
                }
            }else{
                cell.titleLab.text = @"检查更新";
                cell.cacheLab.text = @"v1.1.0";
            }
            
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
            ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
                cell.titleLab.text = @"黑名单";
            }else {
                cell.titleLab.text = @"关于凹凸";
            }
            return cell;
        }
    }else{
        static NSString *CellIdentifier = @"ATQSZLoginOutTableViewCell" ;
        ATQSZLoginOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.loginoutblock = ^{
            NSLog(@"退出登录");
            [self performSelector:@selector(loginout) withObject:self afterDelay:0.5];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ATQUserInfoViewController *vc = [[ATQUserInfoViewController alloc] init];
        vc.dic = _dic;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ATQSetupSecrityViewController *vc = [[ATQSetupSecrityViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            ATQUserManualViewController *vc = [[ATQUserManualViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            ATQOpinionViewController *vc = [[ATQOpinionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            ATQBlackListViewController *vc = [[ATQBlackListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:nil message:@"确定要清除所有缓存吗？" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *sureAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                isClear = YES;
                [self.tableView reloadData];
                 NSLog(@"-----");
            }];
            
            [sureAction setValue:[UIColor colorWithHexString:UIColorStr] forKey:@"titleTextColor"];
            
            UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                isClear = NO;
                [self.tableView reloadData];
                NSLog(@".....");
            }];
            [cancelAction setValue:[UIColor colorWithHexString:UIToneTextColorStr] forKey:@"titleTextColor"];
            [alertController addAction:cancelAction];
            [alertController addAction:sureAction];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alertController animated:YES completion:nil];
            });
            
        }else if (indexPath.row == 2){
            ATQAboutAQTViewController *vc = [[ATQAboutAQTViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if(indexPath.section == 4){
        return 80;
    }else{
        return 40;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 4) {
        
        return nil;
    }else if(section == 1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-20, 40)];
        lab.text = @"账户安全";
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor colorWithHexString:@"8B8B8B"];
        [view addSubview:lab];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else if (section == 2){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ScreenWidth-20, 40)];
        lab.text = @"帮助与反馈";
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor colorWithHexString:@"8B8B8B"];
        [view addSubview:lab];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 4) {
        return 0;
    }else if (section == 1 || section == 2){
        return 40;
    }else{
        return 10;
    }
}

-(void)loginout{
    [(AppDelegate *)[UIApplication sharedApplication].delegate openLoginCtrl];
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
