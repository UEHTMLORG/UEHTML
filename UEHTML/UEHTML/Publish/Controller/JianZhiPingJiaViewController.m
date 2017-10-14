//
//  JianZhiPingJiaViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiPingJiaViewController.h"

@interface JianZhiPingJiaViewController (){
    
    WWStarView * _firstStarView;
    WWStarView * _secondStarView;
    WWStarView * _thirdStarView;
    UITextView * _textView;
}

@end

@implementation JianZhiPingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    /*
     
     WWStarView *vc=[[WWStarView alloc]initWithFrame:CGRectMake(0, 100, 240, 40) numberOfStars:5 currentStar:5 rateStyle:WholeStar isAnination:YES andamptyImageName:@"face_s" fullImageName:@"face_n" finish:^(CGFloat currentStar) {
     
     }];
     
     vc.delegate = self;
     
     vc.backgroundColor=[UIColor redColor];
     
     [self.view addSubview:vc];
     
     */
    [self loadUIview];
}
- (void)loadUIview{
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Light_Gray_Color];
    UIView * firstBackView = [UIView new];
    firstBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstBackView];
    [firstBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(135.0f);
    }];
    
    UILabel * firstLabel = [UILabel new];
    firstLabel.text = @"兼职技能";
    [firstBackView addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(firstBackView).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    UILabel * secondLabel = [UILabel new];
    secondLabel.text = @"服务态度";
    [firstBackView addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstBackView).mas_offset(20);
        make.top.mas_equalTo(firstLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    UILabel * thirdLabel = [UILabel new];
    thirdLabel.text = @"照片真实性";
    [firstBackView addSubview:thirdLabel];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstBackView).mas_offset(20);
        make.top.mas_equalTo(secondLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    _firstStarView = [[WWStarView alloc]initWithFrame:CGRectMake(140, 15, 180, 30) numberOfStars:5 currentStar:1 rateStyle:WholeStar isAnination:YES andamptyImageName:@"face_s" fullImageName:@"face_n" finish:^(CGFloat currentStar) {
        
    }];
    _firstStarView.delegate = self;
    [firstBackView addSubview:_firstStarView];
    _secondStarView = [[WWStarView alloc]initWithFrame:CGRectMake(140, 55, 180, 30) numberOfStars:5 currentStar:1 rateStyle:WholeStar isAnination:YES andamptyImageName:@"face_s" fullImageName:@"face_n" finish:^(CGFloat currentStar) {
        
    }];
    _secondStarView.delegate = self;
    [firstBackView addSubview:_secondStarView];
    _thirdStarView = [[WWStarView alloc]initWithFrame:CGRectMake(140, 95, 180, 30) numberOfStars:5 currentStar:1 rateStyle:WholeStar isAnination:YES andamptyImageName:@"face_s" fullImageName:@"face_n" finish:^(CGFloat currentStar) {
        
    }];
    _thirdStarView.delegate = self;
    [firstBackView addSubview:_thirdStarView];
    
    _textView = [UITextView new];
    _textView.delegate = self;
    _textView.text =@"评论：";
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(15);
        make.right.mas_equalTo(self.view).mas_offset(-15);
        make.top.mas_equalTo(firstBackView.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(135.0f);
    }];
    
    UIButton * tijiaoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    [tijiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tijiaoBtn setBackgroundColor:[UIColor colorWithhex16stringToColor:Main_Purple_Color]];
    [tijiaoBtn addTarget:self action:@selector(tjiaoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tijiaoBtn];
    [tijiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view).mas_offset(25);
        make.right.mas_equalTo(self.view).mas_offset(-25);
        make.height.mas_equalTo(30);
    }];
    
}
- (void)tjiaoButtonAction:(UIButton *)sender{
    
    
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
