//
//  ATQMyliftViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyliftViewController.h"
#import "ATQLiftCollectionViewCell.h"
#import "JSBadgeView.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
@interface ATQMyliftViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong ,nonatomic)NSMutableArray *liftArr;

@end

@implementation ATQMyliftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的礼物";
    [self.liftCollectionView registerNib:[UINib  nibWithNibName:@"ATQLiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQLiftCollectionViewCell"];

    self.liftCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.liftCollectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.liftCollectionView.mj_header beginRefreshing];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/gift",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"---gift--%@",responseObject[@"data"]);
        [self.liftCollectionView.mj_header endRefreshing];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if (responseObject[@"data"]) {
                self.liftArr = responseObject[@"data"];
            }
            [self.liftCollectionView reloadData];
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.liftCollectionView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.liftCollectionView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.liftCollectionView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liftArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tempDic = self.liftArr[indexPath.row];
    ATQLiftCollectionViewCell *cell = (ATQLiftCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQLiftCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 4.f;
    cell.layer.masksToBounds = YES;
    [cell.liftImg sd_setImageWithURL:[NSURL URLWithString:tempDic[@"gift_picture"]]];
    cell.liftName.text = tempDic[@"gift_title"];
    JSBadgeView *Badge = [[JSBadgeView alloc]initWithParentView:cell.badgeview alignment:JSBadgeViewAlignmentCenter];
    Badge.badgeText = tempDic[@"gift_num"];
    
    if (Badge.badgeText.floatValue >9) {
        cell.badgeViewW.constant = 30;
    }else if(Badge.badgeText.floatValue >99){
        cell.badgeViewW.constant = 40;
    }
    Badge.badgeBackgroundColor = [UIColor colorWithHexString:UIColorStr];
    Badge.badgeTextColor = [UIColor whiteColor];
    collectionView.scrollEnabled = NO;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----->%ld",indexPath.row);
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    float width = (ScreenWidth-50)/3;
    return CGSizeMake(width, 13*width/9);
    
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 20, 5, 20);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}


-(NSMutableArray *)liftArr{
    if (_liftArr == nil) {
        _liftArr = [NSMutableArray array];
    }
    return _liftArr;
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
