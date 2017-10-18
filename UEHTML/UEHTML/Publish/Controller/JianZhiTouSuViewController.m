//
//  JianZhiTouSuViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiTouSuViewController.h"



#define Collection_item_Width 70
#define Collection_item_Height (SIZE_WIDTH - 50) / 4.0

@interface JianZhiTouSuViewController ()

@end

@implementation JianZhiTouSuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"投诉";
    // Do any additional setup after loading the view from its nib.
    [self setPhotoCollectionView];
}
/**
 *==========ZL注释start===========
 *1.设置CollectionView
 *
 *2.<#注释描述#>
 *3.<#注释描述#>
 *4.<#注释描述#>
 ===========ZL注释end==========*/
- (void)setPhotoCollectionView{
    //创建CollectionVIew
    //创建一个Layout布局
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为
    layout.itemSize = CGSizeMake(Collection_item_Width, Collection_item_Width);
    //item距离四周的位置（上左下右）
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //item 行与行的距离
    layout.minimumLineSpacing = 10;
    //item 列与列的距离
    layout.minimumInteritemSpacing = 10;
    
    
    [self.photoCollectionView setCollectionViewLayout:layout];
//    self.photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
//    [self addSubview:self.photoCollectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.mas_equalTo(self);
//    }];
    //    NSLog(@"Collection的frame:%g-------%g----%g-----%g------%g-------%g",self.collectionView.frame.size.width,self.collectionView.frame.size.height,Collection_item_Width,Collection_item_Height,self.bounds.size.width,self.bounds.size.height);
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    
//    self.collectionView.scrollEnabled = YES;
    //注册item类型
    
    //[self.backCollectionView registerClass:[DianShiQiangCollectionCell class] forCellWithReuseIdentifier:@"dianShiQiangCellId"];
    [self.photoCollectionView registerNib:[UINib nibWithNibName:@"JianZhiTouSuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JianZhiTouSuCellID"];
    
}




//举报原因 按钮
- (IBAction)juBaoBtnAction:(UIButton *)sender {


}
- (IBAction)tijiaoButtonAction:(UIButton *)sender {
}


#pragma mark CollectionViewCellDelegate 代理方法
#pragma mark CollectionView  的  dataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    NSLog(@"Collection数组为：%ld",self.phoneARR.count);
    //return self.photosARR.count;
    NSInteger  count = self.photosARR.count > 9?9:self.photosARR.count;
    NSInteger reCount;
    if (count == 9) {
        reCount = count;
    }
    else{
        
        reCount = count + 1;
    }
    return reCount;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellId = @"JianZhiTouSuCellID";
    JianZhiTouSuCollectionViewCell *cell = (JianZhiTouSuCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.photosARR.count > 0 && indexPath.row != self.photosARR.count) {
        cell.deleteBtn.hidden = NO;
        [cell.imageViewtou setImage:self.photosARR[indexPath.row]];
    }
    else{
        cell.deleteBtn.hidden = YES;
        [cell.imageViewtou setImage:[UIImage imageNamed:@"jianzhi-photo"]];
        
    }
    //[cell.imageVIewP sd_setImageWithURL:[NSURL URLWithString:self.phoneARR[indexPath.row]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了Cell");
    if (self.photosARR.count == 9) {
        [MBManager showBriefAlert:@"最多添加9张照片"];
        return;
    }
        TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
        pickerController.naviBgColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
        pickerController.needCircleCrop = YES;
        pickerController.circleCropRadius = 100;
        //展示相册中的视频
        pickerController.allowPickingVideo = NO;
        //不展示图片
        pickerController.allowPickingImage = YES;
        //不显示原图选项
        pickerController.allowPickingOriginalPhoto = NO;
        //按时间排序
        pickerController.sortAscendingByModificationDate = YES;
        [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            if (photo.count) {
                [self.photosARR addObjectsFromArray:photo];
                [self.photoCollectionView reloadData];
            }
        }];
    
    [self presentViewController:pickerController animated:YES completion:^{
        
    }];
    
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.photosARR.count > 0 && indexPath.row != self.photosARR.count) {
        return NO;
    }
    else{
        return YES;
    }

}

-(void)deleteButtonAction:(UIButton *)sender{
    [self.photosARR removeObjectAtIndex:sender.tag];
    [self.photoCollectionView reloadData];
    
}

#pragma end mark

- (NSMutableArray *)photosARR{
    if (!_photosARR) {
        _photosARR = [NSMutableArray new];
    }
    return _photosARR;
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
