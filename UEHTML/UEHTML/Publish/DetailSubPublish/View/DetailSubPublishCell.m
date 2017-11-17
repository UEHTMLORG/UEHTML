//
//  DetailSubPublishCell.m
//  UEHTML
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "DetailSubPublishCell.h"

@implementation DetailSubPublishCell
//第一行 Cell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
//第二行  cell
@implementation DetailSubPublishSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.voiceButton.layer setCornerRadius:12.5];
    [self.voiceButton.layer setMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
@implementation DetailSubPublishThirdCell
//第三行 Cell
- (void)awakeFromNib {
    [super awakeFromNib];
   self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
//第四行  cell
@implementation DetailSubPublishFourCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /** 设置LiWuCollectionView */
    [self settingCollectionView];
}

- (void)settingCollectionView{
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(50.0, 50.0);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //item 行与行的距离
    layout.minimumLineSpacing = 20;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 0;
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"LiWuPublishCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"LiWuCollectionIDZl"];
    //[self addSubview:self.collectionView];
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liWuArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"LiWuCollectionIDZl";
    LiWuPublishCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    GiftMTLModel * model = self.liWuArray[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.gift_picture] placeholderImage:[UIImage imageNamed:DEFAULT_GIFTIMAGE]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)bindDataWithModel:(DetailSubPublishModel *)model{
    self.liWuArray = model.gift_list;
    [self.collectionView reloadData];
}
- (NSArray *)liWuArray{
    if (!_liWuArray) {
        _liWuArray = [NSArray new];
    }
    return _liWuArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//第五行  cell
@implementation DetailSubPublishFiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self settingCollectionView];
}

- (void)settingCollectionView{
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(70.0,70.0);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //item 行与行的距离
    layout.minimumLineSpacing = 20;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 0;
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SkillPublishCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"skillCollectionCellID"];
    //[self addSubview:self.collectionView];
}
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.skillArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"skillCollectionCellID";
    SkillPublishCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    /*
     id = "1",     title = "陪聊天",     id = "2",     title = "按摩",
     id = "3",     title = "送红酒",     id = "4",     title = "吃饭",
     id = "5",     title = "看电影",     id = "6",     title = "唱歌",
     id = "7",     title = "旅游",       id = "8",     title = "打游戏",
     id = "9",     title = "运动",       id = "10",    title = "其他",
     */
    SkillMTLModel * model = self.skillArray[indexPath.row];
    if ([model.job_class_id isEqualToString:@"1"]) {
        [cell.imageVIew setImage:[UIImage imageNamed:@"peiliaotian"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"2"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"anmo"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"3"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"songhongjiu"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"4"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"chifan"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"5"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"kandianying"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"6"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"changge"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"7"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"lvyou"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"8"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"dayouxi"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else if ([model.job_class_id isEqualToString:@"9"]){
        [cell.imageVIew setImage:[UIImage imageNamed:@"yundong"]];
        cell.nameLabel.text = model.job_class_name;
    }
    else {
        [cell.imageVIew setImage:[UIImage imageNamed:@"peiliaotian"]];
        cell.nameLabel.text = model.job_class_name;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)bindDataWithModel:(DetailSubPublishModel *)model{
    self.skillArray = model.skill_list;
    [self.collectionView reloadData];
}
- (NSArray *)skillArray{
    if (!_skillArray) {
        _skillArray = [NSArray new];
    }
    return _skillArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation DetailSubPublishSixCell
//第六行 Cell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
@implementation DetailSubPublishSevenCell
//第七行 Cell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


