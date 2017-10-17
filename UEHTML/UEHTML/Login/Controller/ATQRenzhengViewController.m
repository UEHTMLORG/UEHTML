//
//  ATQRenzhengViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/21.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQRenzhengViewController.h"

@interface ATQRenzhengViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *pickerController;
@end

@implementation ATQRenzhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self takePhoto];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (UIImagePickerController *)pickerController{
    
    if (!_pickerController) {
        
        _pickerController = [[UIImagePickerController alloc]init];
        _pickerController.delegate = self;
        _pickerController.view.backgroundColor = [UIColor redColor];
        _pickerController.allowsEditing = NO;
        
    }
    return _pickerController;
}

/**
 拍照
 */
- (void)takePhoto {
    
//    if(![self checkLibraryAndCameraAuthStatus]) return;
    
    // 调用相机
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        //系统相机
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        //设置默认调用前置摄像头
        _pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:_pickerController animated:YES completion:nil];
        
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *userImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        NSLog(@"%@",userImage);
        
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
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
