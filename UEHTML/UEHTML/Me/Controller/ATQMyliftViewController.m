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
@interface ATQMyliftViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ATQMyliftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的礼物";
    [self.liftCollectionView registerNib:[UINib  nibWithNibName:@"ATQLiftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQLiftCollectionViewCell"];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *imgarr = @[@"fujin-peiliaotian",@"fujin-anmo",@"fujin-wine",@"fujin-eat",@"fujin-movie",@"fujin-sing",@"fujin-tourism",@"fujin-game",@"fujin-sport"];
    NSArray *namearr = @[@"棒棒糖",@"咖啡",@"蛋糕",@"巧克力",@"粉玫瑰",@"花束",@"毛绒玩具",@"范思哲",@"IWatch"];
    NSArray *badgearr = @[@"25",@"4",@"56",@"12",@"9",@"4",@"100",@"45",@"7"];
    ATQLiftCollectionViewCell *cell = (ATQLiftCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQLiftCollectionViewCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 4.f;
    cell.layer.masksToBounds = YES;
    cell.liftImg.image = [UIImage imageNamed:imgarr[indexPath.row]];
    cell.liftName.text = namearr[indexPath.row];
    JSBadgeView *Badge = [[JSBadgeView alloc]initWithParentView:cell.badgeview alignment:JSBadgeViewAlignmentCenter];
    Badge.badgeText = badgearr[indexPath.row];
    
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
