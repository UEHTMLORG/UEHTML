//
//  ATQNearbyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQNearbyViewController.h"
#import "ATQTypeListViewController.h"
#import "ATQJZTypeListViewController.h"
#import "ATQTagTableViewCell.h"
#import "ATQRecPerTableViewCell.h"
#import "ATQTagCollectionViewCell.h"
#import "ATQRecPerCollectionViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "XHHPageControl.h"
#import "UIColor+LhkhColor.h"
#import "ATQTypeListInviteDetailViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
@interface ATQNearbyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,BMKLocationServiceDelegate>{
    UIView *headView;
    NSMutableArray *_imageArray;//滚动图数组
    BMKLocationService* _locService;
    NSString *lat;
    NSString *lon;

}
@property (nonatomic,strong)UITableView *tableView;
@property (strong,nonatomic)UIScrollView *imageScrollView;
@property (strong,nonatomic)XHHPageControl *pagecontrol;
@property (strong,nonatomic)NSTimer *timer;


@end

@implementation ATQNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    _imageArray = [NSMutableArray array];
    NSArray *array = @[@"http://img5.imgtn.bdimg.com/it/u=503735038,481712869&fm=200&gp=0.jpg",@"http://img2.imgtn.bdimg.com/it/u=3438207759,2243402979&fm=200&gp=0.jpg",@"http://img3.imgtn.bdimg.com/it/u=742446113,121668976&fm=200&gp=0.jpg"];
    [_imageArray addObjectsFromArray:array];
    _locService = [[BMKLocationService alloc]init];
    [_locService startUserLocationService];
    [self buildheadView];
    
}

-(void)viewWillAppear:(BOOL)animated {
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    _locService.delegate = nil;
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    lat = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] ;
    lon = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] ;
    NSLog(@"lat===%@----log===%@",lat,lon);
    [self loadData];
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"lat"] = lat;
    params[@"lon"] = lon;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/home/index",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----home=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                
            }
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
        [tableView registerNib:[UINib nibWithNibName:@"ATQTagTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQTagTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQRecPerTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQRecPerTableViewCell"];
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
    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(60);
        make.bottom.mas_equalTo(self.view).offset(-54);
    }];
    
}

-(void)buildheadView{
    
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*170/375)];
    _imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth*170/375)];
    _pagecontrol = [[XHHPageControl alloc]initWithFrame:CGRectMake((ScreenWidth-100)/2, ScreenWidth*170/375-20, 100, 20)];
    _pagecontrol.userInteractionEnabled = NO;
    [headView addSubview:_imageScrollView];
    [headView addSubview: _pagecontrol];
    if (![_imageArray isKindOfClass:[NSNull class]]) {//防崩溃
        [self imageUIInit];
    }
    [self addTimer];
}


-(MJRefreshAutoNormalFooter *)loadMoreDataFooterWith:(UIScrollView *)scrollView {
    MJRefreshAutoNormalFooter *loadMoreFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //        [self loadMoreData];
        [scrollView.mj_footer endRefreshing];
    }];
    
    return loadMoreFooter;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"tableviewCellID";
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        
        [cell addSubview:headView];
        
    }else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"ATQTagTableViewCell" ;
        ATQTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tagCollectionView.delegate = self;
        cell.tagCollectionView.dataSource = self;
        cell.tagCollectionView.tag = 0;
        [cell.tagCollectionView registerNib:[UINib  nibWithNibName:@"ATQTagCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQTagCollectionViewCell"];
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQRecPerTableViewCell" ;
        ATQRecPerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftCollectionView.delegate = self;
        cell.leftCollectionView.dataSource = self;
        cell.leftCollectionView.tag = 1;
        [cell.leftCollectionView registerNib:[UINib  nibWithNibName:@"ATQRecPerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQRecPerCollectionViewCell"];
        cell.midCollectionView.delegate = self;
        cell.midCollectionView.dataSource = self;
        cell.midCollectionView.tag = 2;
        [cell.midCollectionView registerNib:[UINib  nibWithNibName:@"ATQRecPerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQRecPerCollectionViewCell"];
        cell.rightCollectionView.delegate = self;
        cell.rightCollectionView.dataSource = self;
        cell.rightCollectionView.tag = 3;
        [cell.rightCollectionView registerNib:[UINib  nibWithNibName:@"ATQRecPerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQRecPerCollectionViewCell"];
        return cell;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ScreenWidth*170/375;
    }else if(indexPath.section == 1){
        float width = (ScreenWidth-60)/5;
        return 2*(7*width/5+5);
    }else{
        float width = (ScreenWidth-80)/3;
        return 10*(14*width/8+20);
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 5;
    }else{
        return 0;
    }
}

#pragma mark- 图片相关
- (void)imageUIInit {
    
    CGFloat imageScrollViewWidth = ScreenWidth;
    CGFloat imageScrollViewHeight = _imageScrollView.bounds.size.height;
    
    for(int i = 0; i<_imageArray.count; i++) {
        if ([_imageArray[i] isKindOfClass:[NSNull class]]) {
            continue;
        }
    }
    for (int i=0; i<_imageArray.count; i++) {
        
        UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(imageScrollViewWidth*i, 0, imageScrollViewWidth,imageScrollViewHeight)];
        
        [imageview sd_setImageWithURL:[NSURL URLWithString:_imageArray[i]] placeholderImage:[UIImage imageNamed:@""]];

//        imageview.contentMode = UIViewContentModeScaleAspectFit;
//        imageview.tag = i;
//        imageview.userInteractionEnabled = YES;
//        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
//        [imageview addGestureRecognizer:singleTap];
        [_imageScrollView addSubview:imageview];
    }
    
    _imageScrollView.contentSize = CGSizeMake(imageScrollViewWidth*_imageArray.count, 0);
    _imageScrollView.bounces = NO;
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.delegate = self;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    
    _pagecontrol.numberOfPages = _imageArray.count;
    
}

//开启定时器
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

//设置当前页 实现自动滚动
- (void)nextImage
{
    int page = (int)_pagecontrol.currentPage;
    
    if (page == _imageArray.count-1) {
        
        page = 0;
        
    }else{
        
        page++;
        
    }
    
    CGFloat x = page * _imageScrollView.frame.size.width;
    [_imageScrollView  setContentOffset:CGPointMake(x, 0) animated:NO];
    
}
//关闭定时器
- (void)removeTimer
{
    [self.timer invalidate];
}

#pragma mark ScrollView代理方法开始
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _imageScrollView) {
        CGFloat scrollviewW =  scrollView.frame.size.width;
        CGFloat x = scrollView.contentOffset.x;
        int page = (x + scrollviewW / 2) /  scrollviewW;
        _pagecontrol.currentPage = page;
    }
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *imgarr = @[@"fujin-peiliao",@"fujin-anmo",@"fujin-wine",@"fujin-eat",@"fujin-movie",@"fujin-sing",@"fujin-tourism",@"fujin-game",@"fujin-sport",@"fujin-other",];
    NSArray *namearr = @[@"陪聊天",@"按摩",@"送红酒",@"吃饭",@"看电影",@"唱歌",@"旅游",@"打游戏",@"运动",@"其他",];
    if (collectionView.tag == 0) {
        ATQTagCollectionViewCell *cell = (ATQTagCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQTagCollectionViewCell" forIndexPath:indexPath];
        cell.tagImg.image = [UIImage imageNamed:imgarr[indexPath.row]];
        cell.tagLab.text = namearr[indexPath.row];
        collectionView.scrollEnabled = NO;
        return cell;
    }else{
        ATQRecPerCollectionViewCell *cell = (ATQRecPerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQRecPerCollectionViewCell" forIndexPath:indexPath];
        collectionView.scrollEnabled = NO;
        CGSize size = cell.frame.size;
        cell.recpImg.layer.cornerRadius = size.width/2;
        cell.recpImg.layer.masksToBounds = YES;
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----->%ld",indexPath.row);
    if (collectionView.tag == 0) {
        NSArray *namearr = @[@"陪聊天",@"按摩",@"送红酒",@"吃饭",@"看电影",@"唱歌",@"旅游",@"打游戏",@"运动",@"其他",];
        ATQJZTypeListViewController *vc = [[ATQJZTypeListViewController alloc] init];
        vc.navigationItem.title = namearr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        ATQTypeListInviteDetailViewController *vc = [[ATQTypeListInviteDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        float width = (ScreenWidth-60)/5;
        return CGSizeMake(width, 7*width/5);
    }else{
        float width = (ScreenWidth-80)/3;
        return CGSizeMake(width, 14*width/8);
    }
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 0) {
         return UIEdgeInsetsMake(5, 10, 5, 10);
    }else{
         return UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
}


- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag == 0) {
        return 5.f;
    }
    return 10.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
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
