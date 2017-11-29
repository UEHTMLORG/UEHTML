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
    ///api/job/video_chat/open
    //pictures  videos
    if (self.photoArray.allKeys.count == 3 && self.videoArray.allKeys.count == 2) {
        /** 提交审核 */
        [self okButtonAction];
    }
    else{
        [MBManager showBriefAlert:@"请完善资料"];
    }
     [self okButtonAction];
}
/** 提交资料 */
- (void)okButtonAction{
    NSString * picStringArr = [self.photoArray.allValues componentsJoinedByString:@","];
    NSString * videoStringArr = [self.videoArray.allValues componentsJoinedByString:@","];
    NSLog(@"上传图片的参数：%@",picStringArr);
    NSString * renZhengURL = [NSString stringWithFormat:@"%@/api/job/video_chat/open",Common_URL_ZL];
    NSDictionary * parma = @{
                             @"pictures":picStringArr,
                             @"videos":videoStringArr
                             };
    [MBManager showLoading];
    
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:renZhengURL parameters:parma success:^(id responseObject) {
        [MBManager hideAlert];
       
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"开通视频：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            [MBManager showBriefAlert:@"上传成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        [MBManager hideAlert];
    }];
    
}
/**
 *==========ZL注释start===========
 *1.上传照片
 *
 ===========ZL注释end==========*/
- (void)uploadImageWithImage:(UIImage *)image{
    //api/user/upload_picture
    NSString * upImageString = [NSString stringWithFormat:@"%@/api/user/upload_picture",Common_URL_ZL];
    
    NSData * imageData = UIImageJPEGRepresentation(image, 0.2);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary * parmaDic = @{
                                @"picture_type":@"avatar",
                                @"picture":encodedImageStr
                                };
    [MBManager showLoading];
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:upImageString parameters:parmaDic success:^(id responseObject) {
        [MBManager hideAlert];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"上传图片：%@",dic);
        if ([dic[@"status"] isEqualToString:@"1"]) {
            [self.photoArray setValue:dic[@"data"] forKey:[NSString stringWithFormat:@"%ld",_currentPhotoIndex]];
        }
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
                                @"video_type":@"video_chat",
                                @"video":encodedImageStr
                                };
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
