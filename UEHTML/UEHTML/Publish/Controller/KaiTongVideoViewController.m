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
- (void)uploadImage{
    //api/user/upload_picture
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
                                    @"appversion":@"1.0.0",
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
