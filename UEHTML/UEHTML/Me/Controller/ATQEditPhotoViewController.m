//
//  ATQEditPhotoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/29.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQEditPhotoViewController.h"
#import "ATQMyAlbumViewController.h"
@interface ATQEditPhotoViewController ()<IsSecretDelegate>

@end

@implementation ATQEditPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.image;
}
- (IBAction)secretClick:(id)sender {
    self.secretBtn.selected = !self.secretBtn.selected;
    if ([self.isSecretdelegate respondsToSelector:@selector(passValue:)]) {
        [self.isSecretdelegate passValue:self.secretBtn.selected];
    }
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
