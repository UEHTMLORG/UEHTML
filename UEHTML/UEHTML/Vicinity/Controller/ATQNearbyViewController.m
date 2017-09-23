//
//  ATQNearbyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQNearbyViewController.h"
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
@interface ATQNearbyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    UIView *headView;
    NSMutableArray *_imageArray;//滚动图数组
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
    [self buildheadView];
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
    if (collectionView.tag == 0) {
        ATQTagCollectionViewCell *cell = (ATQTagCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQTagCollectionViewCell" forIndexPath:indexPath];
        cell.tagImg.layer.cornerRadius = (ScreenWidth-60)/10;
        cell.tagImg.layer.masksToBounds = YES;
        collectionView.scrollEnabled = NO;
        return cell;
    }else{
        ATQRecPerCollectionViewCell *cell = (ATQRecPerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQRecPerCollectionViewCell" forIndexPath:indexPath];
        collectionView.scrollEnabled = NO;
        CGSize size = cell.frame.size;
        cell.recpImg.layer.cornerRadius = size.width/2;
        cell.recpImg.layer.masksToBounds = YES;
        NSLog(@"%@",NSStringFromCGSize(size));
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----->%ld",indexPath.row);
    
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
