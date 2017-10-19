//
//  ATQFaceRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQFaceRZViewController.h"
#import "ATQPerfectInfoViewController.h"
#import "DetectorView.h"
#import "UIColor+LhkhColor.h"
#import "MBProgressHUD+Add.h"
#import "LhkhHttpsManager.h"
@interface ATQFaceRZViewController ()
{
    NSTimer *timer;
    NSInteger timeCount;
    
}
@property(nonatomic,strong)DetectorView *detector;
@property(nonatomic,strong)UIImageView *frontImageView;
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *tishiLabel;
@end

@implementation ATQFaceRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"202020"];
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 25, 25)];
    [backbtn setImage:[UIImage imageNamed:@"zhuce-Top zuo"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIButton *voicebtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, 30, 25, 25)];
    [voicebtn setImage:[UIImage imageNamed:@"zhuce-shengyin"] forState:UIControlStateNormal];
    [voicebtn addTarget:self action:@selector(voice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:voicebtn];
    
    UILabel *tishiLab = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-90)/2, 60, 90, 20)];
    tishiLab.text = @"请眨眼";
    tishiLab.textAlignment = NSTextAlignmentCenter;
    tishiLab.textColor = [UIColor whiteColor];
    [self.view addSubview:tishiLab];
    self.timeLabel = tishiLab;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenWidth*373/320)];
    imageview.image = [UIImage imageNamed:@"zhuce-zhayan"];
    [self.view addSubview:imageview];
    DetectorView *detector = [[DetectorView alloc] initWithFrame:CGRectMake(15, 150, ScreenWidth-30, ScreenWidth*373/320 - 100)];
    detector.layer.cornerRadius = (ScreenWidth-30)/2;
    detector.layer.masksToBounds = YES;
    [self.view addSubview:detector];
    self.detector = detector;
    self.detector.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth  - 60)/2, CGRectGetMaxY(imageview.frame), 100, 30)];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:tipLabel];
    self.tishiLabel = tipLabel;
    
    __weak typeof(self) weakSelf = self;
    
    self.detector.getStringBlock = ^(NSDictionary *resultDict){
        
        if ([[resultDict objectForKey:@"result"] boolValue]) {
            NSLog(@"检测成功");
            [weakSelf timeBegin];
        }
        else{
            NSLog(@"检测失败");
            [weakSelf releaseTimer];
        }
        tipLabel.text = resultDict[@"desc"];
    };
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)voice{
    
    NSLog(@"点击了声音");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}



#pragma mark - 强制改屏幕
- (void)timeBegin{
    if (timer) {
        return;
    }
    timeCount = 3;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCalculate:) userInfo:nil repeats:YES];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ld s后拍照...", (long)timeCount];
}
- (void)releaseTimer{
    if (timer) {
        [timer invalidate];
        timer = nil;
        self.timeLabel.text = @"";
    }
}
- (void)timeCalculate:(NSTimer *)theTimer{
    timeCount --;
    if(timeCount >= 1)
    {
        self.timeLabel.text = [NSString  stringWithFormat:@"%ld s后拍照...",(long)timeCount];
    }
    else
    {
        self.timeLabel.text = @"检测成功";
        self.tishiLabel.hidden = YES;
        [theTimer invalidate];
        theTimer=nil;
        
        if (self.detector.takePhotoBlock) {
            self.detector.takePhotoBlock(self.showImageView);
            [self commit];
        }
        
    }
}

-(void)commit{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"user_token"] = user_token;
    params[@"user_id"] = user_id;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = @"1.0.0";
    NSString *random_str = [ZLSecondAFNetworking getNowTime];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [ZLSecondAFNetworking getMD5fromString:signStr];
    NSString *sign2 = [ZLSecondAFNetworking getMD5fromString:sign1];
    NSString *sign = [ZLSecondAFNetworking getMD5fromString:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/register/step2",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----register/step2=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            ATQPerfectInfoViewController *vc = [[ATQPerfectInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"登录失败：%@",error);
    }];
}

//- (void)cancelPhoto{
//    if (self.detector.cancelPhotoBlock) {
//        self.detector.cancelPhotoBlock();
//    }else{
//        NSLog(@"22");
//    }
//
//    self.showImageView.image = nil;
//}

-(void)dealloc{
    
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
