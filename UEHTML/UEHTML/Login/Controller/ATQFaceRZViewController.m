//
//  ATQFaceRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQFaceRZViewController.h"
#import "DetectorView.h"
@interface ATQFaceRZViewController ()
{
    NSTimer *timer;
    NSInteger timeCount;
    
}
@property(nonatomic,strong)DetectorView *detector;
@property(nonatomic,strong)UIImageView *frontImageView;
@property(nonatomic,strong)UIImageView *showImageView;
@property(nonatomic,strong)UILabel *timeLabel;
@end

@implementation ATQFaceRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backbtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 15, 15)];
    [backbtn setImage:[UIImage imageNamed:@"zhuce-Top zuo"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 94, 375, 400)];
    imageview.image = [UIImage imageNamed:@"zhuce-zhayan"];
    [self.view addSubview:imageview];
    DetectorView *detector = [[DetectorView alloc] initWithFrame:CGRectMake((ScreenWidth - 360) / 2, 94, 360, 300)];
    detector.layer.cornerRadius = 180.f;
    detector.layer.masksToBounds = YES;
    [self.view addSubview:detector];
    self.detector = detector;
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(CGRectGetMaxX(detector.frame) - 80, CGRectGetMaxY(detector.frame) + 15, 80, 30);
    [cancelBtn setTitle:@"清除" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor yellowColor];
    [cancelBtn addTarget:self action:@selector(cancelPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(cancelBtn.frame) + 15, 100, 100)];
    [self.view addSubview:showImageView];
    showImageView.clipsToBounds = YES;
    self.showImageView = showImageView;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 50, CGRectGetMaxY(self.showImageView.frame), 100, 30)];
    [self.view addSubview:tipLabel];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 100, CGRectGetMaxY(tipLabel.frame) + 15, 200, 30)];
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    self.detector.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    
    __weak typeof(self) weakSelf = self;
    
    self.detector.getStringBlock = ^(NSDictionary *resultDict){
        
        if ([[resultDict objectForKey:@"result"] boolValue]) {
            
            [weakSelf timeBegin];
        }
        else{
            
            [weakSelf releaseTimer];
        }
        tipLabel.text = resultDict[@"desc"];
    };
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:NO];
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
        [theTimer invalidate];
        theTimer=nil;
        if (self.detector.takePhotoBlock) {
            self.detector.takePhotoBlock(self.showImageView);
        }
        
    }
}
- (void)cancelPhoto{
    if (self.detector.cancelPhotoBlock) {
        self.detector.cancelPhotoBlock();
    }else{
        NSLog(@"22");
    }
    
    self.showImageView.image = nil;
}

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
