//
//  ATQMePublishViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/16.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMePublishViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Masonry.h"
#import "ATQMePublishFTableViewCell.h"
#import "ATQMePublishPTableViewCell.h"
#import "ATQMepublishTTableViewCell.h"
#import "UIColor+LhkhColor.h"
#import "KZPhotoManager.h"
#import "LhkhHttpsManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"
#import "ATQDTImageView.h"
#import "ZJImageViewBrowser.h"
#import "NSString+ZJ.h"
#import "ATQMyFriendsViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "ATQPublishAddrViewController.h"
@interface ATQMePublishViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPMediaPickerControllerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,CLLocationManagerDelegate,BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,ATQPublishAddrViewControllerDelegate,ATQMyFriendsViewControllerDelegate,ATQMePublishFTableViewCellDelegate>{
    float height;
    NSString *_publishStr;
    NSString *selStr;
    NSString *chakanStr;
    NSString *_addrStr;
    NSString *_useridStr1;
    NSString *_useridStr2;
    NSString *_lat;
    NSString *_lon;
    NSString *_picStr;
    NSString *_vedioStr;
    UIImage *vedioImg;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)BMKLocationService *locService;
@property (nonatomic, strong)BMKGeoCodeSearch *geocodesearch;
@property BOOL isGeoSearch;
@property (nonatomic, strong)NSMutableArray *addressArr;


@end

@implementation ATQMePublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(publish)];
    self.navigationItem.leftBarButtonItem = left;
    self.navigationItem.rightBarButtonItem = right;
    height = 110;
    NSLog(@"----%@",self.typeStr);
    [self setTableView];
    
    //启动LocationService
    _locService = [[BMKLocationService alloc]init];//定位功能的初始化
    _locService.delegate = self;//设置代理位self
    [_locService startUserLocationService];//启动定位服务
    
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)publish{
    NSLog(@"发表");
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    NSString *model = nil;
    if ([self.typeStr isEqualToString:@"0"]) {
        model = @"1";
    }else if ([self.typeStr isEqualToString:@"1"]){
        model = @"2";
    }else if([self.typeStr isEqualToString:@"2"]){
        model = @"3";
    }
    NSString *who_see = @"";
    if ([chakanStr isEqualToString:@"公开"]) {
        who_see = @"1";
    }else if ([chakanStr isEqualToString:@"私密"]){
        who_see = @"2";
    }else{
        who_see = @"3";
    }
    params[@"model"] = model;
    params[@"lat"] = _lat;
    params[@"lon"] = _lon;
    params[@"desc"] = _publishStr;
    params[@"who_see"] = who_see;
    params[@"who_see_list"] = _useridStr1;
    params[@"pictures"] = _picStr;
    params[@"video"] = _vedioStr;
    params[@"remind_see_list"] = _useridStr2;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/circle/send",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----send=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }
            
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
          
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{

            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {

        NSLog(@"%@",error);
    }];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishFTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishFTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishPTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishPTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMepublishTTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMepublishTTableViewCell"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        return 3;
    }else{
        return 4;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 2) {
            return 2;
        }else{
            return 1;
        }
        
    }else{
        if (section == 3) {
            return 2;
        }else{
            return 1;
        }
        
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"ATQMePublishFTableViewCell" ;
            ATQMePublishFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            static NSString *CellIdentifier = @"ATQMepublishTTableViewCell" ;
            ATQMepublishTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (indexPath.section == 1) {
                cell.typeImg.image = [UIImage imageNamed:@"aotuquan-dingwei"];
                cell.typeTitleLab.text = @"所在位置";
                cell.subLab.text = _addrStr;
            }else{
                if (indexPath.row == 0) {
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-kejian"];
                    cell.typeTitleLab.text = @"谁可以看";
                    cell.subLab.hidden = NO;
                    cell.subLab.text = chakanStr;
                }else{
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-"];
                    cell.typeTitleLab.text = @"提醒谁看";
                    cell.subLab.hidden = YES;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
    
        if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"ATQMePublishFTableViewCell" ;
            ATQMePublishFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.section == 1){
            static NSString *CellIdentifier = @"ATQMePublishPTableViewCell" ;
            ATQMePublishPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.typeStr isEqualToString:@"1"]) {
                cell.vedioBtn.hidden = YES;
                cell.vedioImg.hidden = YES;
                cell.publishCollectionView.hidden = NO;
                cell.xuanZeTuPianBlock = ^(){//选择图片
                    
                    [KZPhotoManager getImage:^(UIImage *image) {
                        ATQMePublishPTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                        [cell.imgsArray insertObject:image atIndex:0];
                        [cell.publishCollectionView reloadData];
                        CGFloat width = (ScreenWidth - 50)/4;
                        if (cell.imgsArray.count >0 && cell.imgsArray.count <= 4) {
                            height = 110;
                        }else if (cell.imgsArray.count >4 && cell.imgsArray.count <= 8){
                            height = 110 + width + 20;
                        }else{
                            height = 110 + 2*width + 30;
                        }
                        if (cell.imgsArray.count >1) {
                            UIImage *firImg = cell.imgsArray[0];
                            NSData *data = UIImageJPEGRepresentation(firImg, 0.3);
                            NSString *picStr = [data base64EncodedStringWithOptions:0];
                            [self uploadImage:picStr secretType:@"1"];
                        }
                        [weakself.tableView reloadData];
                    } showIn:weakself AndActionTitle:@"请选择照片"];
                };
                cell.deleteTuPianBlock = ^{
                    
                    ATQMePublishPTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                    CGFloat width = (ScreenWidth - 50)/4;
                    if ((cell.imgsArray.count-1)>0 && (cell.imgsArray.count-1) <= 4) {
                        height = 110;
                    }else if ((cell.imgsArray.count-1) >4 && (cell.imgsArray.count-1) <= 8){
                        height = 110 + width + 20;
                    }else{
                        height = 110 + 2*width + 30;
                    }
                    [weakself.tableView reloadData];
                };
                
            }else{
                cell.vedioBtn.hidden = NO;
                cell.vedioImg.hidden = NO;
                cell.publishCollectionView.hidden = YES;
                cell.vedioImg.image = vedioImg?:[UIImage imageNamed:@"aotuquan-tianjia01"];
                cell.vedioselectBlock = ^{
                    selStr = @"image";
                    [self selectType];
                };
            }
            
            return cell;
            
        }else {
            static NSString *CellIdentifier = @"ATQMepublishTTableViewCell" ;
            ATQMepublishTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (indexPath.section == 2) {
                cell.typeImg.image = [UIImage imageNamed:@"aotuquan-dingwei"];
                cell.typeTitleLab.text = @"所在位置";
                cell.subLab.text = _addrStr;
            }else{
                if (indexPath.row == 0) {
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-kejian"];
                    cell.typeTitleLab.text = @"谁可以看";
                    cell.subLab.hidden = NO;
                    cell.subLab.text = chakanStr;
                }else{
                    cell.typeImg.image = [UIImage imageNamed:@"aotuquan-"];
                    cell.typeTitleLab.text = @"提醒谁看";
                    cell.subLab.hidden = YES;
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]){
        if (indexPath.section == 1) {
            ATQPublishAddrViewController *vc = [[ATQPublishAddrViewController alloc] init];
            vc.delegate = self;
            vc.addrArr = self.addressArr;
            [self.navigationController pushViewController:vc animated:NO];
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                [self selectType];
            }else{
                ATQMyFriendsViewController *vc = [[ATQMyFriendsViewController alloc]init];
                vc.delegate = self;
                vc.selecttypeStr = @"select2";
                [self.navigationController pushViewController:vc animated:NO];
            }
        }
    }else{
        
        if (indexPath.section == 2) {
            ATQPublishAddrViewController *vc = [[ATQPublishAddrViewController alloc] init];
            vc.delegate = self;
            vc.addrArr = self.addressArr;
            [self.navigationController pushViewController:vc animated:NO];
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                [self selectType];
            }else{
                ATQMyFriendsViewController *vc = [[ATQMyFriendsViewController alloc]init];
                vc.delegate = self;
                vc.selecttypeStr = @"select2";
                [self.navigationController pushViewController:vc animated:NO];
            }        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
            return 44;
        }else{
            return height;
        }
        
    }else{
        return 44;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 1) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else if(section == 2){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else{
            return nil;
        }
    }else{
        if (section == 2) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else if(section == 3){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
            view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
            return view;
        }else{
            return nil;
        }
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.typeStr != nil && [self.typeStr isEqualToString:@"2"]) {
        if (section == 1) {
            return 1;
        }else if(section == 2){
            return 30;
        }else{
            return 0;
        }
    }else{
        if (section == 2) {
            return 1;
        }else if(section == 3){
            return 30;
        }else{
            return 0;
        }
    }
    
}

-(void)selectType{
    
    if ([self.typeStr isEqualToString:@"0"]) {
        selStr = @"image";
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择视频" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从相册选取", nil];
        [sheet showInView:self.view];
    }else{
        selStr = @"chakan";
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"公开" otherButtonTitles:@"部分人可见",@"私密", nil];
        [sheet showInView:self.view];
    }
    
}

#pragma UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([selStr isEqualToString:@"image"]) {
        NSInteger sourcetype = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                    return;
                    break;
                case 1:
                    sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 0:
                    sourcetype = UIImagePickerControllerSourceTypeCamera;
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
        imggePickerVc.mediaTypes = @[(NSString *)kUTTypeMovie];
        [self presentViewController:imggePickerVc animated:NO completion:nil];
    }else if ([selStr isEqualToString:@"chakan"]){
        if (buttonIndex == 0) {
            chakanStr = @"公开";
        }else if (buttonIndex == 1){
            chakanStr = @"部分人可见";
            ATQMyFriendsViewController *vc = [[ATQMyFriendsViewController alloc]init];
            vc.delegate = self;
            vc.selecttypeStr = @"select1";
            [self.navigationController pushViewController:vc animated:NO];
            
        }else if (buttonIndex == 2){
            chakanStr = @"私密";
        }else{
            
        }
        [self.tableView reloadData];
    }
    
}

#pragma UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"found a video");
        
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:videoURL options:NSDataReadingUncached error:&error];
        if (!error) {
            
            double size = (long)data.length / 1024. / 1024.;
            //
            //            self.vediolb.text = [NSString stringWithFormat:@"%.2fMB", size];
            if (size > 30.0) {
                
                //文件过大
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"视频文件不得大于30M" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancle];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                
                //保存数据
                //获取视频的thumbnail
                MPMoviePlayerController *player = [[MPMoviePlayerController alloc]initWithContentURL:videoURL] ;
                NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
                NSString *videoStr = [videoData base64EncodedStringWithOptions:0];
                [self uploadImage:videoStr secretType:@"0"];
                UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
                player = nil;
                vedioImg = thumbnail;
                [self.tableView reloadData];
            }
        }
        
    }
    
    
    
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}


-(void)uploadImage:(NSString *)imageStr secretType:(NSString*)secrettype{
   
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    NSString *subUrl = nil;
    if ([secrettype isEqualToString:@"1"]) {
        params[@"picture_type"] = @"circle";
        params[@"picture"] = imageStr;
        subUrl = @"/api/user/upload_picture";
    }else{
        
        params[@"video_type"] = @"circle";
        params[@"video"] = imageStr;
        subUrl = @"/api/user/upload_video";
    }
    
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
    NSString *url = [NSString stringWithFormat:@"%@%@",ATQBaseUrl,subUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----upload_picture=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                if ([secrettype isEqualToString:@"1"]) {
                    NSString *imgstr = responseObject[@"data"];
                    if (_picStr == nil) {
                        _picStr = imgstr;
                    }else{
                        _picStr = [NSString stringWithFormat:@"%@,%@",_picStr,imgstr];
                    }
                }else{
                    _vedioStr = responseObject[@"data"];
                }
                NSLog(@"---%@---%@",_picStr,_vedioStr);
            }
            
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"地图定位失败======%@",error);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    
//    //从manager获取左边
//    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;//位置坐标
    
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0))
    {

        [self sendBMKReverseGeoCodeOptionRequest];
        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
        _lat = latitude;
        _lon = longitude;
        
    }else{
        NSLog(@"位置为空");
    }
    
    //关闭坐标更新
    [self.locService stopUserLocationService];
}

-(void)ATQMePublishFTableViewCellDelegate:(NSString *)text{
    NSLog(@"----%@",text);
    _publishStr = text;
}

-(void)ATQPublishAddrViewControllerDelegate:(NSString *)addrStr{
    _addrStr = addrStr;
    [self.tableView reloadData];
}

-(void)ATQMyFriendsViewControllerDelegate:(NSString *)addrStr seleType:(NSString*)seletype{
    NSLog(@"----%@",addrStr);
    if ([seletype isEqualToString:@"select1"]) {
        _useridStr1 = addrStr;
    }else{
        _useridStr2 = addrStr;
    }
    
}

#pragma mark ----反向地理编码
//发送反编码请求
- (void)sendBMKReverseGeoCodeOptionRequest{

    self.isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (_locService.userLocation.location.coordinate.longitude!= 0
        && _locService.userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){_locService.userLocation.location.coordinate.latitude,
            _locService.userLocation.location.coordinate.longitude};
    }

    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

//发送成功,百度将会返回东西给你
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                          result:(BMKReverseGeoCodeResult *)result
                       errorCode:(BMKSearchErrorCode)error
{
 
    if (error == BMK_SEARCH_NO_ERROR) {

        NSLog(@"-----%@----%@----%@----%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName);
        for(BMKPoiInfo *poiInfo in result.poiList)
        {
            NSLog(@"我的位置在%@",poiInfo);
            [self.addressArr addObject:poiInfo.address];
        }
//        NSLog(@"我的位置在 %@",result);
        
        //保存位置信息到模型
//        [self.userLocationInfoModel saveLocationInfoWithBMKReverseGeoCodeResult:result];
        
        //进行缓存处理，上传到服务器等操作
    }
}

//地图定位
- (BMKLocationService *)locService
{
    if (!_locService)
    {
        _locService = [[BMKLocationService alloc] init];
        _locService.delegate = self;
    }
    return _locService;
}

//检索对象
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch)
    {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}


-(NSMutableArray*)addressArr{
    if (_addressArr == nil) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
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
