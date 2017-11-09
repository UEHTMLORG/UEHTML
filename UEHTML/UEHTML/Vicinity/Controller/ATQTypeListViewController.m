//
//  ATQTypeListViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTypeListViewController.h"
#import "ATQTypePeoDetailViewController.h"
#import "ATQTypeListTableViewCell.h"
#import "Masonry.h"
#import "UIButton+Lhkh.h"
#import "UIColor+LhkhColor.h"
@interface ATQTypeListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *paixuStr;
}
@property (nonatomic,strong)UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *paixutableView;
@property (nonatomic,strong)NSArray *paixuArr;
@end

@implementation ATQTypeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.paixuBtn changeImageAndTitle];
    [self.shaixuanBtn changeImageAndTitle];
    [self setTableView];
}

-(void)setTableView{
    self.paixutableView.hidden = YES;
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQTypeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQTypeListTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(40);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableView) {
        return 10;
    }else{
        return 3;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        static NSString *CellIdentifier = @"ATQTypeListTableViewCell" ;
        ATQTypeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"UITableViewCell" ;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.textLabel.text = _paixuArr[indexPath.section];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        return 100;
    }else{
        return 30;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {
        ATQTypePeoDetailViewController *vc = [[ATQTypePeoDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        paixuStr = _paixuArr[indexPath.section];
        self.paixutableView.hidden = YES;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if (section == 0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else{
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView) {
        if (section == 0) {
            return 5;
        }else{
            return 10;
        }
    }else{
        return 0;
    }
    
}

- (IBAction)paixuClick:(id)sender {
    self.paixutableView.hidden = NO;
    [self.paixutableView reloadData];
}
- (IBAction)shaixuanClick:(id)sender {
}

-(NSArray*)paixuArr{
    if (_paixuArr == nil) {
        _paixuArr = [[NSArray alloc] initWithObjects:@"最新发布",@"距离最近",@"诚信度最高", nil];
    }
    return _paixuArr;
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
