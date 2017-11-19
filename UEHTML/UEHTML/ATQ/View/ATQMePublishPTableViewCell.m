//
//  ATQMePublishPTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMePublishPTableViewCell.h"
#import "ATQAddImgCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"
#define MaxPic 9
@interface ATQMePublishPTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@end
@implementation ATQMePublishPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.publishCollectionView.dataSource = self;
    self.publishCollectionView.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.publishCollectionView registerNib:[UINib nibWithNibName:@"ATQAddImgCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQAddImgCollectionViewCell"];
}
- (IBAction)vedioClick:(id)sender {
    if (_vedioselectBlock) {
        _vedioselectBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgsArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ATQAddImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ATQAddImgCollectionViewCell" forIndexPath:indexPath];
    id img = [_imgsArray objectAtIndex:indexPath.row];
    //    if ([img isKindOfClass:[NSString class]]) { //如果是string类型
    //
    //        if ([img hasSuffix:@"webp"]) {
    //            [cell.selImg setZLWebPImageWithURLStr:img withPlaceHolderImage:PLACEHOLDER_IMAGE];
    //        } else {
    //            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:PLACEHOLDER_IMAGE];
    //        }
    //    }else{
    //        cell.imgView.image = img;
    //    }
    cell.selImg.image = img;
    cell.delBtn.hidden = (indexPath.row == self.imgsArray.count-1);
    __weak typeof(self) weakself = self;
    cell.addImgCollectionDelBlock = ^(){
        if (_deleteTuPianBlock) {
            _deleteTuPianBlock();
        }
        [weakself.imgsArray removeObjectAtIndex:indexPath.row];
        [weakself.publishCollectionView reloadData];
    };
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (ScreenWidth - 50)/4;
    return CGSizeMake(cellW,cellW);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.imgsArray.count-1 ) { //点击到+号按钮
        if (self.imgsArray.count < MaxPic+1) {
            if (self.xuanZeTuPianBlock) {
                self.xuanZeTuPianBlock();
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"最多上传9张额" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
}


- (NSMutableArray *)imgsArray{
    if (!_imgsArray) {
        _imgsArray = [NSMutableArray array];
        [_imgsArray addObject:[UIImage imageNamed:@"aotuquan-tianjia01"]];
        
    }
    return _imgsArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
