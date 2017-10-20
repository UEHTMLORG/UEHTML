//
//  ATQEditPhotoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/29.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQEditPhotoViewController.h"
#import "ATQMyAlbumViewController.h"
#import "UIImageView+WebCache.h"
@interface ATQEditPhotoViewController ()

@end

@implementation ATQEditPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"my-jiazhaopian"]];
    
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
