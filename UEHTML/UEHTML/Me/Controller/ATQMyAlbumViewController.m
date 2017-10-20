//
//  ATQMyAlbumViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyAlbumViewController.h"
#import "ATQPhotoTableViewCell.h"
#import "ATQPhotoCollectionViewCell.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "ATQEditPhotoViewController.h"
#import "ATQSCMyAlumbViewController.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "ATQAlumbModel.h"
@interface ATQMyAlbumViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL isSecretPhoto;
    UILabel *topLab;
    UILabel *bottomLab;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *imageArr;
@end

@implementation ATQMyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的相册";
    self.view.backgroundColor = RGBA(236, 236, 236, 1);
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(shangchuan)];
    right.tintColor = [UIColor colorWithHexString:UISelTextColorStr];
    self.navigationItem.rightBarButtonItem = right;
    [self loadData];
    [self setcollectionView];
}

-(void)shangchuan{
    ATQSCMyAlumbViewController *vc = [[ATQSCMyAlumbViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/album/show",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----album/show=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self.imageArr removeAllObjects];
            if (responseObject[@"data"]) {
                self.imageArr = [ATQAlumbModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
            topLab.text = [NSString stringWithFormat:@"你还可以上传%ld照片",(12-self.imageArr.count)];
            bottomLab.text = @"照片可以上传8张普通照片,4张私密照片";
            [self.collectionView reloadData];
            
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)setcollectionView{
    float width = (ScreenWidth-55)/4;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, width*3+20) collectionViewLayout:flowLayout];
    
    [self.view addSubview:_collectionView];
    [_collectionView registerNib:[UINib  nibWithNibName:@"ATQPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQPhotoCollectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    UIView *Dview = [[UIView  alloc]initWithFrame:CGRectZero];
    Dview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:Dview];
    topLab = [[UILabel alloc] initWithFrame:CGRectZero];
    topLab.font = [UIFont systemFontOfSize:14];
    topLab.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    bottomLab = [[UILabel alloc] initWithFrame:CGRectZero];
    bottomLab.font = [UIFont systemFontOfSize:14];
    bottomLab.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [Dview addSubview:topLab];
    [Dview addSubview:bottomLab];
    
    [Dview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_collectionView.mas_bottom).offset(10);
        make.height.offset(20);
    }];
    [topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Dview).offset(20);
        make.right.mas_equalTo(Dview).offset(-20); make.top.mas_equalTo(Dview).offset(10);
        make.height.offset(20);
    }];
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(Dview).offset(20);
        make.right.mas_equalTo(Dview).offset(-20); make.top.mas_equalTo(topLab.mas_bottom).offset(10);
        make.height.offset(20);
    }];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.5;
    [self.collectionView addGestureRecognizer:longPressGesture];
}
/*
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQPhotoTableViewCell"];
        
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
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQPhotoTableViewCell" ;
    ATQPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.photoCollectionView.delegate = self;
    cell.photoCollectionView.dataSource = self;
    
    [cell.photoCollectionView registerNib:[UINib  nibWithNibName:@"ATQPhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQPhotoCollectionViewCell"];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.5;
    longPressGesture.view.tag = indexPath.row;
    
    [cell.photoCollectionView addGestureRecognizer:longPressGesture];
    
    [cell.photoCollectionView reloadData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float width = (ScreenWidth-55)/4;
    return width*3+90;
}
*/
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    ATQPhotoCollectionViewCell *cell = (ATQPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQPhotoCollectionViewCell" forIndexPath:indexPath];
   
    cell.delBtn.hidden = YES;
    if (self.imageArr.count >indexPath.row) {
         NSLog(@"----imageArr=%ld",_imageArr.count);
        ATQAlumbModel *model = self.imageArr[indexPath.row];
        [cell.userImg sd_setImageWithURL:[NSURL URLWithString:model.picture]];
        if ([model.model isEqualToString:@"1"]) {
            cell.secretView.hidden = NO;
        }else{
            cell.secretView.hidden = YES;
        }
        cell.deleteTupianblock = ^{
            [weakself DeletePicture:model.ID];
        };
    }else{
        cell.userImg.image = [UIImage imageNamed:@"my-jiazhaopian"];
        cell.secretView.hidden = YES;
        cell.delBtn.hidden = YES;
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"------");
    if (self.imageArr.count>indexPath.row) {
        
        ATQAlumbModel *model = self.imageArr[indexPath.row];
        
        ATQEditPhotoViewController *vc = [[ATQEditPhotoViewController alloc]init];
        vc.imageStr = model.picture;
        vc.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }else{
            self.modalPresentationStyle=UIModalPresentationCurrentContext;
            
        }
        [self presentViewController:vc  animated:YES completion:^(void)
         {
             vc.view.superview.backgroundColor = [UIColor clearColor];
         }];
    }
   
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    float width = (ScreenWidth-55)/4;
    return CGSizeMake(width, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
  
    return UIEdgeInsetsMake(0, 20, 0, 20);
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

-(void)longPressGesture:(UILongPressGestureRecognizer *)tap{
    CGPoint pointTouch = [tap locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
    ATQPhotoCollectionViewCell *cell = (ATQPhotoCollectionViewCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath == nil) {
        cell.delBtn.hidden = YES;
    }else{
        cell.delBtn.hidden = NO;
    }
}

-(void)DeletePicture:(NSString*)ID{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"id"] = ID;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/album/delete",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----album/delete=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self loadData];
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(NSMutableArray*)imageArr{
    
    if (_imageArr == nil) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
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
