//
//  JianZhiTouSuViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiTouSuViewController.h"

@interface JianZhiTouSuViewController ()

@end

@implementation JianZhiTouSuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)xuanQuPhoto{
    
    TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    pickerController.naviBgColor = [UIColor greenColor];
    pickerController.needCircleCrop = YES;
    pickerController.circleCropRadius = 100;
    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (photo.count) {

        }
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
