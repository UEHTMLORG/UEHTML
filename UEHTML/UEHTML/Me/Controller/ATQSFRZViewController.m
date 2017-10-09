//
//  ATQSFRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSFRZViewController.h"

@interface ATQSFRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSString *imgType;
}

@end

@implementation ATQSFRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份认证";
}
- (IBAction)xiugaiClick:(id)sender {
    imgType = @"headImg";
    [self selectImage];
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
    if ([imgType isEqualToString:@"headImg"]) {
        self.headImg.image = image;
    }else if ([imgType isEqualToString:@"zhengImg"]){
        self.zhengImg.image = image;
    }else{
        self.cardImg.image = image;
    }
    
    //    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    //    NSString *picStr = [data base64EncodedStringWithOptions:0];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
