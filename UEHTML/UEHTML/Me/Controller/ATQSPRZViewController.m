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
@interface ATQSPRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,MPMediaPickerControllerDelegate>

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
                UIImage  *thumbnail = [player thumbnailImageAtTime:0.01 timeOption:MPMovieTimeOptionNearestKeyFrame];
                player = nil;
                self.vedioImg.image = thumbnail;
            }
        }
        
    }
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
