//
//  ATQCarRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQCarRZViewController.h"
#import "LhkhHttpsManager.h"
#import "UIColor+LhkhColor.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
@interface ATQCarRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString *imgType;
    NSString *driving_license;
    NSString *driver_license;
    NSString *car_picture;
}

@end

@implementation ATQCarRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车辆认证";
}
- (IBAction)xszImgClick:(id)sender {
    imgType = @"xszImg";
    [self selectImage];
}
- (IBAction)jszImgClick:(id)sender {
    imgType = @"jszImg";
    [self selectImage];
}
- (IBAction)carImgClick:(id)sender {
    imgType = @"carImg";
    [self selectImage];
}
- (IBAction)commitClick:(id)sender {
    NSLog(@"driving_license=%@-driver_license=%@-car_picture=%@",driving_license,driver_license,car_picture);
    if (driving_license != nil && driver_license != nil && car_picture != nil) {
        NSMutableDictionary *params = [NSMutableDictionary  dictionary];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
        NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
        params[@"driving_license"] = driving_license;
        params[@"driver_license"] = driver_license;
        params[@"car_picture"] = car_picture;
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
        NSString *url = [NSString stringWithFormat:@"%@/api/user/auth_car",ATQBaseUrl];
        
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
    params[@"picture_type"] = @"car";
    params[@"picture"] = imageStr;
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/upload_picture",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----upload_picture=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                NSString *imgStr = responseObject[@"data"];
                if ([imgType isEqualToString:@"xszImg"]) {
                    [self.xszImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                    driving_license = imgStr;
                }else if ([imgType isEqualToString:@"jszImg"]){
                    
                    [self.jszImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                    driver_license = imgStr;
                }else{
                    
                    [self.carImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"renzheng-photo"]];
                    car_picture = imgStr;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
