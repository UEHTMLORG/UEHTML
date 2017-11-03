//
//  ATQOpinionPhotoTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQOpinionPhotoTableViewCell.h"
#import "ATQAddImgCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define MaxPic 5
@interface ATQOpinionPhotoTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@end
@implementation ATQOpinionPhotoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.photoCollectionView.dataSource = self;
    self.photoCollectionView.delegate = self;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"ATQAddImgCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ATQAddImgCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgsArray.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
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
        if (_deleteSCTuPianBlock) {
            _deleteSCTuPianBlock();
        }
        [weakself.imgsArray removeObjectAtIndex:indexPath.row];
        [weakself.photoCollectionView reloadData];
    };
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = 80;
    return CGSizeMake(cellW,cellW);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 5);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.imgsArray.count-1 ) { //点击到+号按钮
        if (self.imgsArray.count < MaxPic+1) {
            if (self.xuanZeTuPianBlock) {
                self.xuanZeTuPianBlock();
            }
        }
    }
}


- (NSMutableArray *)imgsArray{
    if (!_imgsArray) {
        _imgsArray = [NSMutableArray array];
        [_imgsArray addObject:[UIImage imageNamed:@"shezhi-photo"]];
        
    }
    return _imgsArray;
}

@end
