//
//  ATQSPRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSPRZViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
@interface ATQSPRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,MPMediaPickerControllerDelegate>{
    NSString *vedioString;
}

@end

@implementation ATQSPRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频认证";
}
- (IBAction)shangchuanVedio:(id)sender {
    [self selectImage];
}
- (IBAction)commitClick:(id)sender {
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"video"] = vedioString;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_video",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----auth_video=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                
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

//更换头像
-(void)selectImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择视频" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从手机相册选择", nil];
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
//    imggePickerVc.allowsEditing = YES;
    imggePickerVc.sourceType = sourcetype;
    imggePickerVc.mediaTypes = @[(NSString *)kUTTypeMovie];
    [self presentViewController:imggePickerVc animated:NO completion:nil];
}

#pragma UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@",[NSString stringWithFormat:@"%f s",[self getVideoLength:videoURL]]);
        NSLog(@"%@",[NSString stringWithFormat:@"%.2f kb",[self getFileSize:[videoURL path]]]);
        
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
                vedioString = videoStr;
                UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
                player = nil;
                self.vedioImg.image = thumbnail;
            }
        }
        
    }
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)uploadVideo:(NSString *)videoStr{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"video"] = videoStr;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_video",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----auth_video=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
  
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

#pragma mark --获取视频信息的方法--
//此方法可以获取文件的大小，返回的是单位是KB。
-(CGFloat)getFileSize:(NSString *)path{
    NSLog(@"文件的路径%@",path);
    NSFileManager * fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary * fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize]longLongValue];
        filesize = 1.0 * size/1024;
    } else {
        NSLog(@"找不到这个文件");
    }
    return filesize;
}
//这个方法获取的是视频文件的时长
-(CGFloat)getVideoLength:(NSURL *)url{
    AVAsset * avUrl = [AVAsset assetWithURL:url];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
