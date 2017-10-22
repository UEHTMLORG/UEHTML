//
//  ATQSFRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSFRZViewController.h"
#import "LhkhHttpsManager.h"
#import "UIColor+LhkhColor.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
#import "ATQFaceRZViewController.h"
@interface ATQSFRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,FaceRZIsSuccessDelegate>
{
    NSString *imgType;
    NSString *id_positive;
    NSString *hold_url;
}

@end

@implementation ATQSFRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份认证";
}
- (IBAction)xiugaiClick:(id)sender {
    
    ATQFaceRZViewController *vc = [[ATQFaceRZViewController alloc] init];
    vc.delegate = self;
    vc.vcStr = @"ATQSFRZViewController";
    [self.navigationController pushViewController:vc animated:YES];
//    [self selectImage];
}
-(void)passValue:(NSString *)SusStr{
    if (SusStr !=nil && [SusStr isEqualToString:@"1"]) {
        imgType = @"headImg";
        [self selectImage];
    }
}
- (IBAction)cardListClick:(id)sender {
}
- (IBAction)zhengImgClick:(id)sender {
    imgType = @"zhengImg";
    [self selectImage];
}
- (IBAction)cardImgClick:(id)sender {
    imgType = @"cardImg";
    [self selectImage];
}
- (IBAction)commitClick:(id)sender {
    NSLog(@"idcard=%@-id_positive=%@-hold_url=%@",self.cardNumText.text,id_positive,hold_url);
    if (self.cardNumText.text != nil && id_positive != nil && hold_url != nil) {
        NSMutableDictionary *params = [NSMutableDictionary  dictionary];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
        NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
        params[@"id_number"] = self.cardNumText.text;
        params[@"id_positive"] = id_positive;
        params[@"hold_url"] = hold_url;
        params[@"user_id"] = user_id;
        params[@"user_token"] = user_token;
        params[@"apptype"] = @"ios";
        params[@"appversion"] = @"1.0.0";
        NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
        params[@"random_str"] = random_str;
        NSString *app_token = APP_TOKEN;
        NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
        NSString *sign1 = [LhkhHttpsManager md5:signStr];
        NSString *sign2 = [LhkhHttpsManager md5:sign1];
        NSString *sign = [LhkhHttpsManager md5:sign2];
        params[@"sign"] = sign;
        NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_id_info",ATQBaseUrl];
        
        [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
            NSLog(@"-----auth_car=%@",responseObject);
            if ([responseObject[@"status"] isEqualToString:@"1"]) {
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
                
            }else{
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        [MBProgressHUD show:@"请先完善信息" view:self.view];
    }
}

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
    
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    NSString *picStr = [data base64EncodedStringWithOptions:0];
    [self uploadImage:picStr secretType:imgType];
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)uploadImage:(NSString *)imageStr secretType:(NSString*)secrettype{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    NSString *subUrl = nil;
    if ([secrettype isEqualToString:@"headimg"]) {
        params[@"avatar"] = imageStr;
        params[@"avatar_auth"] = @"1";
        subUrl = @"/api/user/upload_avatar";
    }else{
        params[@"picture_type"] = @"id_info";
        params[@"picture"] = imageStr;
        subUrl = @"/api/user/upload_picture";
    }
    
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = @"1.0.0";
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
                NSString *imgStr = responseObject[@"data"];
                if ([imgType isEqualToString:@"headImg"]) {
                    
                    [self.headImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                }else if ([imgType isEqualToString:@"zhengImg"]){
                    hold_url = imgStr;
                    [self.zhengImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                }else{
                    id_positive = imgStr;
                    [self.cardImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                }
            }
            
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
