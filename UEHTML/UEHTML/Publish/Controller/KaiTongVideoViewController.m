//
//  KaiTongVideoViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "KaiTongVideoViewController.h"

@interface KaiTongVideoViewController (){
    
    NSInteger _currentPhotoIndex;
    NSInteger _currentVideoIndex;
}

@end

@implementation KaiTongVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开通视频聊天";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)shangChuanPhotoAction:(UIButton *)sender {
    //    [self uploadImage];
    [KZPhotoManager getImage:^(UIImage *image) {
        
        _currentPhotoIndex = sender.tag;
        [weak_self(self) uploadImageWithImage:image];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        
        
    } showIn:self AndActionTitle:@"选择照片"];
    
}

- (IBAction)shangChuanVideoAction:(UIButton *)sender {
    
    _currentVideoIndex = sender.tag;
    [KZPhotoManager getVideo:^(NSURL *videoURL) {
        
    } withData:^(NSData *videoData) {
        [weak_self(self) uploadVideoWith:videoData];
    } withFirstImage:^(UIImage *firstimage) {
        [sender setBackgroundImage:firstimage forState:UIControlStateNormal];
    } showIn:self AndActionTitle:@"选取视频"];
}



- (IBAction)tijiaoButtonAction:(id)sender {
}

/**
 *==========ZL注释start===========
 *1.上传照片
 *
 *2.
 *3.
 *4.
 ===========ZL注释end==========*/
- (void)uploadImageWithImage:(UIImage *)image{
    //api/user/upload_picture
    NSString * upImageString = [NSString stringWithFormat:@"%@/api/user/upload_picture",Common_URL_ZL];
    
    NSData * imageData = UIImageJPEGRepresentation(image, 0.2);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * parmaDic = @{
                                @"picture_type":@"car",
                                @"picture":encodedImageStr
                                };
    //    UploadParam * uploadParamImage = [[UploadParam alloc]init];
    //    uploadParamImage.data = UIImageJPEGRepresentation(image, 0.5);
    //    uploadParamImage.mimeType = @"jpg";
    //    uploadParamImage.name = @"测试测试";
    //    uploadParamImage.filename = @"car测试";
    //    NSLog(@"上传照片的parmaDic:%@",parmaDic);
    //    [[ZLSecondAFNetworking sharedInstance] uploadWithURLString:upImageString parameters:[ZLSecondAFNetworking joinParamsWithDict:parmaDic] uploadParam:@[uploadParamImage] success:^(id responseObject) {
    //        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //         NSLog(@"上传请求成功：%@",dic);
    //    } failure:^(NSError *error) {
    //        NSLog(@"上传请求失败：%@",error);
    //    }];
    [MBManager showLoading];
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:upImageString parameters:parmaDic success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传图片：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            [self.photoArray setValue:dic[@"data"] forKey:[NSString stringWithFormat:@"%ld",_currentPhotoIndex]];
        }
        NSString * upImageString = [NSString stringWithFormat:@"%@/api/user/upload_picture",Common_URL_ZL];
        
        NSString *random_str = [ZLSecondAFNetworking getNowTime];
        NSString * app_token_string = [kUserDefaults objectForKey:USER_TOEKN_AOTU_ZL];
        NSString *app_token = app_token_string?:@"apptest";
        NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
        NSString *sign1 = [ZLSecondAFNetworking getMD5fromString:signStr];
        NSString *sign2 = [ZLSecondAFNetworking getMD5fromString:sign1];
        NSString *sign = [ZLSecondAFNetworking getMD5fromString:sign2];
        NSString * userid = [kUserDefaults objectForKey:USER_ID_AOTU_ZL];
        /*
         @"apptype":@"ios",
         @"appversion":@"1.0.0",
         @"random_str":random_str,
         @"sign":sign,
         @"user_token":app_token,
         @"user_id":userid
         */
        NSDictionary * parmaDic = @{
                                    @"picture_type":@"car",
                                    @"apptype":@"ios",
                                    @"appversion":APPVERSION_AOTU_ZL,
                                    @"random_str":random_str,
                                    @"sign":sign,
                                    @"user_token":app_token,
                                    @"user_id":userid
                                    };
    NSLog(@"上传照片的parmaDic:%@",parmaDic);
        [[ZLSecondAFNetworking sharedInstance] postWithURLString:upImageString parameters:parmaDic success:^(id responseObject) {
            NSDictionary * dataJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"上传请求成功：%@",dataJson);
        } failure:^(NSError *error) {
            NSLog(@"上传请求失败：%@",error);
        }];
        
    } failure:^(NSError *error) {
         [MBManager hideAlert];
        NSLog(@"上传请求失败：%@",error);
    }];
    
}
//上传视频
-(void)uploadVideoWith:(NSData *)videoData{
    ///api/user/upload_video
    NSString * upImageString = [NSString stringWithFormat:@"%@/api/user/upload_video",Common_URL_ZL];
    NSString *encodedImageStr = [videoData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * parmaDic = @{
                                @"video_type":@"video",
                                @"video":encodedImageStr
                                };
    //    UploadParam * uploadParamImage = [[UploadParam alloc]init];
    //    uploadParamImage.data = UIImageJPEGRepresentation(image, 0.5);
    //    uploadParamImage.mimeType = @"jpg";
    //    uploadParamImage.name = @"测试测试";
    //    uploadParamImage.filename = @"car测试";
    //    NSLog(@"上传照片的parmaDic:%@",parmaDic);
    //    [[ZLSecondAFNetworking sharedInstance] uploadWithURLString:upImageString parameters:[ZLSecondAFNetworking joinParamsWithDict:parmaDic] uploadParam:@[uploadParamImage] success:^(id responseObject) {
    //        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //         NSLog(@"上传请求成功：%@",dic);
    //    } failure:^(NSError *error) {
    //        NSLog(@"上传请求失败：%@",error);
    //    }];
    [MBManager showLoading];
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:upImageString parameters:parmaDic success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传视频：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            [self.videoArray setValue:dic[@"data"] forKey:[NSString stringWithFormat:@"%ld",_currentVideoIndex]];
        }
    } failure:^(NSError *error) {
        [MBManager hideAlert];
        NSLog(@"上传请求失败：%@",error);
    }];
    
}


- (NSMutableDictionary *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableDictionary new];
    }
    return _photoArray;
}
- (NSMutableDictionary *)videoArray{
    if (!_videoArray) {
        _videoArray = [NSMutableDictionary new];
    }
    return _videoArray;
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
