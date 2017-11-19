//
//  ZhaoRenFuWuViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ZhaoRenFuWuViewController.h"

@interface ZhaoRenFuWuViewController ()

@end

@implementation ZhaoRenFuWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布需求";
   /** UITableView注册方法 */
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"FaBuFirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FaBuTableVIewCellID"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FaBuJianZhiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FaBuJianZhiTableVIewSecCellID"];
    
}

#pragma mark ===================UITableView 代理方法实现 START==================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 180.0f;
    }
    else{
        return 450.0f;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString * cellID = @"FaBuTableVIewCellID";
        FaBuFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        
        return cell;
    }
    else{
        static NSString * cellID = @"FaBuJianZhiTableVIewSecCellID";
        FaBuJianZhiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        [cell.shiLiButton addTarget:self action:@selector(shiLiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.tiJiaoShenHeButton addTarget:self action:@selector(tiJiaoShenHeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //实例化长按手势监听
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(luYinButtonAction:)];
        //代理
        longPress.delegate = self;
        longPress.minimumPressDuration = 1.0;
        [cell.luYinImageView addGestureRecognizer:longPress];
        return cell;
    }
}
#pragma mark ===================UITableView 代理方法实现 END==================
#pragma mark ===================Cell的按钮执行方法实现==================
/* 录音ImageView执行方法*/
/** 录音按钮 */
- (void)luYinButtonAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    NSLog(@"长按执行方法");
    if (gestureRecognizer.state ==  UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        [[ZLLuYinManager shareInstance] startRecord];
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        [[ZLLuYinManager shareInstance] stopRecord];
    }
}
/** 示例按钮 */
- (void)shiLiButtonAction:(UIButton *)sender{
    
    
}
/** 押金认证 */
- (void)yaJinRenZhengAction:(id )sender{
    
    
}
/** 提交审核 */
- (void)tiJiaoShenHeButtonAction:(UIButton *)sender{
    //创建URL
    NSString * urlstring = [ZLLuYinManager shareInstance].cafPathStr;
    NSLog(@"录音播放地址：%@",urlstring);
    //NSURL * url = [NSURL fileURLWithPath:urlstring];
    //NSURL *url = [NSURL URLWithString:urlstring];
    NSURL * url = [NSURL URLWithString:@"http://218.76.27.57:8080/chinaschool_rs02/135275/153903/160861/160867/1370744550357.mp3"];
    //创建播放器
   AVPlayer *avPlayer = [[AVPlayer alloc] initWithURL:url];
   [avPlayer play];
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
