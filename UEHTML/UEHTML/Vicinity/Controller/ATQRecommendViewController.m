//
//  ATQRecommendViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRecommendViewController.h"
#import "ATQHomeRecCollectionViewCell.h"
#import "ATQNewPCollectionViewCell.h"
#import "ATQTitleTableViewCell.h"
#import "ATQItemTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQRecModel.h"
#import "ATQFreshModel.h"
#import "UIImageView+WebCache.h"
@interface ATQRecommendViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *freshArr;
@property (nonatomic,strong)NSMutableArray *recArr;

@end

@implementation ATQRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/home/recommend",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----home/recommend=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_recArr removeAllObjects];
            [_freshArr removeAllObjects];
            if(responseObject[@"data"]){
                self.recArr = [ATQRecModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"recommend_list"]];
                self.freshArr = [ATQFreshModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"fresh_list"]];
            }
            [self.tableView reloadData];
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

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQItemTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQTitleTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        self.tableView.mj_header.automaticallyChangeAlpha = YES;
        [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(60);
        make.bottom.mas_equalTo(self.view).offset(-54);
    }];
    
}

-(MJRefreshAutoNormalFooter *)loadMoreDataFooterWith:(UIScrollView *)scrollView {
    MJRefreshAutoNormalFooter *loadMoreFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //        [self loadMoreData];
        [scrollView.mj_footer endRefreshing];
    }];
    
    return loadMoreFooter;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ATQTitleTableViewCell" ;
        ATQTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.titleLab.text = @"新鲜人物";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleCollectionView.delegate = self;
        cell.titleCollectionView.dataSource = self;
        cell.titleCollectionView.tag = 0;
        [cell.titleCollectionView registerNib:[UINib  nibWithNibName:@"ATQNewPCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQNewPCollectionViewCell"];
        [cell.titleCollectionView reloadData];
        return cell;
        
    }else{
        static NSString *CellIdentifier = @"ATQItemTableViewCell" ;
        ATQItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.titleLab.text = @"推荐用户";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemCollectionView.delegate = self;
        cell.itemCollectionView.dataSource = self;
        cell.itemCollectionView.tag = 1;
        [cell.itemCollectionView registerNib:[UINib  nibWithNibName:@"ATQHomeRecCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQHomeRecCollectionViewCell"];
        [cell.itemCollectionView reloadData];
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        float width = (ScreenWidth-50)/4;
        return 8*width/7+40;
    }else{
        float width = (ScreenWidth-40)/2;
        long count = (self.recArr.count+1)/2;
        return count*(10*width/7+10)+40;
    }
    
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 0) {
        return self.freshArr.count;
    }
    return self.recArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        ATQNewPCollectionViewCell *cell = (ATQNewPCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQNewPCollectionViewCell" forIndexPath:indexPath];
        if (self.freshArr.count>0) {
            ATQFreshModel *model = self.freshArr[indexPath.row];
            [cell.personImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
            cell.nameLab.text = model.nick_name;
            cell.disLab.text = model.distance;
        }
        return cell;
    }else{
        ATQHomeRecCollectionViewCell *cell = (ATQHomeRecCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQHomeRecCollectionViewCell" forIndexPath:indexPath];
        collectionView.scrollEnabled = NO;
        if (self.recArr.count>0) {
            ATQRecModel *model = self.recArr[indexPath.row];
            [cell.recPImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
            [cell.disBtn setTitle:model.distance forState:UIControlStateNormal];
            cell.nameLab.text = model.nick_name;
            cell.lvLab.text = [NSString stringWithFormat:@"诚 %@",model.credit_num] ;
            cell.bqLab.text = model.job_class_name;
        }
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----->%ld",indexPath.row);
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        
        float width = (ScreenWidth-50)/4;
        return CGSizeMake(width, 8*width/7);
        
    }
    float width = (ScreenWidth-40)/2;
    return CGSizeMake(width, 10*width/7);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 0) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

-(NSMutableArray*)recArr{
    if (_recArr==nil) {
        _recArr = [NSMutableArray array];
    }
    return _recArr;
}
-(NSMutableArray*)freshArr{
    if (_freshArr==nil) {
        _freshArr = [NSMutableArray array];
    }
    return _freshArr;
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
