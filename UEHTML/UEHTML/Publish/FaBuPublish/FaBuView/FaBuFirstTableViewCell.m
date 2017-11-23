//
//  FaBuFirstTableViewCell.m
//  UEHTML
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "FaBuFirstTableViewCell.h"

@implementation FaBuFirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self settingCollectionView];
    self.currentType = @"陪聊天";
}

- (void)settingCollectionView{
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(65, 28);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //item 行与行的距离
    layout.minimumLineSpacing = 20;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 20;
    [self.collectionVIew setCollectionViewLayout:layout];
    self.collectionVIew.showsHorizontalScrollIndicator = NO;
    
    self.collectionVIew.delegate = self;
    self.collectionVIew.dataSource = self;
    self.collectionVIew.backgroundColor = [UIColor clearColor];
    [self.collectionVIew registerNib:[UINib nibWithNibName:@"FuWuTypeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fuwuTypeCellID"];
    //[self addSubview:self.collectionVIew];
    
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.typeArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"fuwuTypeCellID";
    FuWuTypeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-chat"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-chat02"] forState:UIControlStateSelected];
            self.currentButton = cell.imageButton;
            [self.currentButton setSelected:YES];
            //cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
        }
            break;
        case 1:
        {//fabu-button-massage
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-massage"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-massage02"] forState:UIControlStateSelected];
        }
            break;
        case 2:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-wine"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-wine02"] forState:UIControlStateSelected];
        }
            break;
        case 3:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-eat"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-eat02"] forState:UIControlStateSelected];
        }
            break;
        case 4:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-movie"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-movie02"] forState:UIControlStateSelected];
        }
            break;
        case 5:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sing"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sing02"] forState:UIControlStateSelected];
        }
            break;
        case 6:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-tourism"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-tourism02"] forState:UIControlStateSelected];
            
        }
            break;
        case 7:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-game"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-game02"] forState:UIControlStateSelected];
        }
            break;
        case 8:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sport"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-sport02"] forState:UIControlStateSelected];
        }
            break;
        case 9:
        {
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-other"] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"fabu-button-other02"] forState:UIControlStateSelected];
        }
            break;
        default:
            break;
    }
    cell.imageButton.tag = indexPath.row;
    [cell.imageButton addTarget:self action:@selector(typeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了第几个Cell:%ld------%@",indexPath.row,self.typeArray[indexPath.row]);
    //FuWuTypeCollectionViewCell * cell = (FuWuTypeCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //[cell.imageButton setSelected:YES];
    //self.currentType = self.typeArray[indexPath.row];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    //FuWuTypeCollectionViewCell * cell = (FuWuTypeCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    //[cell.imageButton setSelected:NO];

}
/** 按钮实现方法 */
- (void)typeButtonAction:(UIButton *)sender{
    if (sender.isSelected == NO) {
        [self.currentButton setSelected:NO];
        self.currentButton = sender;
        [self.currentButton setSelected:YES];
        self.currentType = self.typeArray[sender.tag];
        
        self.block(sender.tag, self.currentType);
    }
}

- (NSMutableArray *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray new];
        [_typeArray addObjectsFromArray:@[@"陪聊天",@"按摩",@"送红酒",@"吃饭",@"看电影",@"唱歌",@"旅游",@"打游戏",@"运动",@"其他"]];
    }
    return _typeArray;
}

- (void)cellBlockAction:(CellButtonBlock)block{
    self.block = block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
