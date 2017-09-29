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
@interface ATQMyAlbumViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,IsSecretDelegate>{
    NSMutableArray *imgArr;
    BOOL isSecretPhoto;
    NSInteger selImgTag;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQMyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的相册";
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStylePlain target:self action:@selector(shangchuan)];
    right.tintColor = [UIColor colorWithHexString:UISelTextColorStr];
    self.navigationItem.rightBarButtonItem = right;
    imgArr = [NSMutableArray array];
    [self setTableView];
}

-(void)shangchuan{
    [self selectImage];
}

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
    [cell.photoCollectionView reloadData];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float width = (ScreenWidth-55)/4;
    return width*3+90;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ATQPhotoCollectionViewCell *cell = (ATQPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ATQPhotoCollectionViewCell" forIndexPath:indexPath];
    if (imgArr.count > indexPath.row) {
        cell.userImg.image = imgArr[indexPath.row];
    }else{
        cell.userImg.image = [UIImage imageNamed:@"my-jiazhaopian"];
    }
    
    collectionView.scrollEnabled = NO;
    if (selImgTag == indexPath.row) {
        if (isSecretPhoto == YES) {
            cell.secretView.hidden = NO;
        }else{
            cell.secretView.hidden = YES;
        }
    }else{
        cell.secretView.hidden = YES;
    }
    
    
//    cell.userImg.tag = indexPath.row;
//    cell.userImg.userInteractionEnabled = YES;
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapped:)];
//    [cell.userImg addGestureRecognizer:singleTap];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"----->%ld",indexPath.row);
    ATQEditPhotoViewController *vc = [[ATQEditPhotoViewController alloc]init];
    vc.image = imgArr[indexPath.row];
    selImgTag = indexPath.row;
    vc.isSecretdelegate  = self;
   
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

//更换头像
-(void)selectImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册上传" otherButtonTitles:@"拍照上传", nil];
    [sheet showInView:self.view];
}

#pragma UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger sourcetype = 0;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 2:
                return;
                break;
            case 1:
                sourcetype = UIImagePickerControllerSourceTypeCamera;
                break;
            case 0:
                sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                break;
        }
    }else{
        if (buttonIndex == 2) {
            return;
        }else{
            sourcetype = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    UIImagePickerController *imggePickerVc = [[UIImagePickerController alloc]init];
    imggePickerVc.delegate = self;
    imggePickerVc.allowsEditing = YES;
    imggePickerVc.sourceType = sourcetype;
    [self presentViewController:imggePickerVc animated:NO completion:nil];
}

#pragma UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [imgArr addObject:image];
    [self.tableView reloadData];
    //    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    //    NSString *picStr = [data base64EncodedStringWithOptions:0];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)passValue:(BOOL)isSecret{
    isSecretPhoto = isSecret;
    [self.tableView reloadData];
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
