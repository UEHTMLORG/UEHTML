//
//  KaiTongVideoViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "KaiTongVideoViewController.h"

@interface KaiTongVideoViewController ()

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
        [self uploadImageWithImage:image];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        
        
    } showIn:self AndActionTitle:@"选择照片"];
    
}

- (IBAction)shangChuanVideoAction:(UIButton *)sender {
    
    [KZPhotoManager getVideo:^(NSURL *videoURL) {
        
    } withData:^(NSData *videoData) {
        
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
    
        NSDictionary * parmaDic = @{
                                    @"picture_type":@"car",
                                    @"picture":@"测试图片"
                                    };
    UploadParam * uploadParamImage = [[UploadParam alloc]init];
    uploadParamImage.data = UIImageJPEGRepresentation(image, 0.5);
    uploadParamImage.mimeType = @"jpg";
    uploadParamImage.name = @"测试测试";
    uploadParamImage.filename = @"car测试";
    NSLog(@"上传照片的parmaDic:%@",parmaDic);
    [[ZLSecondAFNetworking sharedInstance] uploadWithURLString:upImageString parameters:[ZLSecondAFNetworking joinParamsWithDict:parmaDic] uploadParam:@[uploadParamImage] success:^{
        NSLog(@"上传请求成功：");
    } failure:^(NSError *error) {
         NSLog(@"上传请求失败：%@",error);
    }];

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
