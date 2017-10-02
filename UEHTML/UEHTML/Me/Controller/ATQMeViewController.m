//
//  ATQMeViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMeViewController.h"
#import "ATQMeHeadView.h"
#import "ATQFristTableViewCell.h"
#import "ATQBFristTableViewCell.h"
#import "ATQSecendTableViewCell.h"
#import "ATQThirdTableViewCell.h"
#import "ATQFourTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIColor+LhkhColor.h"
#import "ATQSetupViewController.h"
#import "ATQYajinRZViewController.h"
#import "ATQCollectViewController.h"
#import "ATQVisitorViewController.h"
#import "ATQMyWechatViewController.h"
#import "ATQMyAlbumViewController.h"
#import "ATQBusinessViewController.h"
#import "ATQSpreadMoenyViewController.h"
#import "ATQMyAccountViewController.h"
@interface ATQMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL isBusiness;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ATQMeHeadView *headView;

@end

@implementation ATQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isBusiness = YES;
    [self buildHeadView];
    [self setTableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)buildHeadView{
    _headView = ({
        ATQMeHeadView *headView =[ATQMeHeadView meHeadView];
        headView.frame = CGRectMake(0, 0, ScreenWidth, 185);
        if (isBusiness == YES) {
            headView.cView.hidden = YES;
            headView.VIPView1.hidden = NO;
            headView.VIPView2.hidden = NO;
        }else{
            headView.cView.hidden = NO;
            headView.VIPView1.hidden = YES;
            headView.VIPView2.hidden = YES;
        }
        __weak typeof(self) weakself = self;
        headView.setupblock = ^{
            ATQSetupViewController *vc = [[ATQSetupViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
        headView;
    });
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQBFristTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQBFristTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQFristTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQFristTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQSecendTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSecendTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQThirdTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQThirdTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQFourTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQFourTableViewCell"];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    self.tableView.tableHeaderView = _headView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(-20);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 2;
    }else{
        return 3;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    static NSString * cellID = @"tableviewCellID";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        
        if (isBusiness == YES) {
            static NSString *CellIdentifier = @"ATQBFristTableViewCell" ;
            ATQBFristTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.vipmyaccountblock = ^(){
                NSLog(@"点击了我的账户");
                ATQMyAccountViewController *vc = [[ATQMyAccountViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.vipmyalbumblock = ^{
                NSLog(@"点击了我的相册");
                ATQMyAlbumViewController *vc = [[ATQMyAlbumViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.vipspreadblock = ^{
                NSLog(@"点击了推荐赚钱");
              
                ATQSpreadMoenyViewController *vc = [[ATQSpreadMoenyViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.vipmybusinessblock = ^{
                NSLog(@"点击了我是代理商");
                ATQBusinessViewController *vc = [[ATQBusinessViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQFristTableViewCell" ;
            ATQFristTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myaccountblock = ^(){
                NSLog(@"点击了我的账户");
                ATQMyAccountViewController *vc = [[ATQMyAccountViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.myalbumblock = ^{
                NSLog(@"点击了我的相册");
                ATQMyAlbumViewController *vc = [[ATQMyAlbumViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            cell.spreadblock = ^{
                NSLog(@"点击了推荐赚钱");
                ATQSpreadMoenyViewController *vc = [[ATQSpreadMoenyViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            };
            return cell;
        }
        
        
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"ATQSecendTableViewCell" ;
        ATQSecendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQThirdTableViewCell" ;
        ATQThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.headImg.image = [UIImage imageNamed:@"my-wei"];
            cell.titleLab.text = @"微信号";
            cell.subtitleLab.text = @"设置真实的微信号可以赚钱";
        }else{
            cell.headImg.image = [UIImage imageNamed:@"my-huangguan"];
            cell.titleLab.text = @"押金认证";
            cell.subtitleLab.text = @"交付押金可以增加成功率";
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQFourTableViewCell" ;
        ATQFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.headImg.image = [UIImage imageNamed:@"my-laifang"];
            cell.titleLab.text = @"最近来访";
        }else if (indexPath.row == 1){
            cell.headImg.image = [UIImage imageNamed:@"my-haoyou"];
            cell.titleLab.text = @"好友";
        }else{
            cell.headImg.image = [UIImage imageNamed:@"my-shoucang"];
            cell.titleLab.text = @"我的收藏";
        }
        return cell;
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ATQMyWechatViewController *vc = [[ATQMyWechatViewController alloc]init];
//            [self presentViewController:vc animated:YES completion:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1) {
            ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            ATQVisitorViewController *vc = [[ATQVisitorViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            ATQCollectViewController *vc = [[ATQCollectViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80*ScreenWidth/375;
    }else if (indexPath.section == 1){
        return 110;
    }else{
        return 40;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
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
