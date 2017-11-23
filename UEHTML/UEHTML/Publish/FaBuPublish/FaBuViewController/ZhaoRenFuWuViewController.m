//
//  ZhaoRenFuWuViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ZhaoRenFuWuViewController.h"

@interface ZhaoRenFuWuViewController (){
    
    BOOL _isLvYou;
}

@end

@implementation ZhaoRenFuWuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布兼职";
   /** UITableView注册方法 */
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"FaBuFirstTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FaBuTableVIewCellID"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FaBuJianZhiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FaBuJianZhiTableVIewSecCellID"];
    [self.tableview registerNib:[UINib nibWithNibName:@"FaJianZhiLVYouTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LvYouCellID"];
    self.currentTypeStr = @"陪聊天";
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
        __weak typeof(self) weakSelf = self;
        cell.block = ^(NSInteger index, NSString *currentType) {
            if ([currentType isEqualToString:@"旅游"]) {
                _isLvYou = YES;
                [tableView reloadData];
            }
            else{
                _isLvYou = NO;
                [tableView reloadData];
            }
            weakSelf.currentTypeStr = currentType;
        };
        
        return cell;
    }
    else{
        if (_isLvYou == NO) {
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
            
            cell.yaJinLabel.linkTextAttributes =@{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            __weak typeof(self) weakSelf = self;
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            /*
             NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
             NSRange strRange = {0,[str length]};
             [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
             [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
             */
            return cell;
        }else{
            static NSString * cellID = @"LvYouCellID";
            FaJianZhiLVYouTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            [cell.shiTingButton addTarget:self action:@selector(shiLiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.tiJiaoButton addTarget:self action:@selector(tiJiaoShenHeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            //实例化长按手势监听
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(luYinButtonAction:)];
            //代理
            longPress.delegate = self;
            longPress.minimumPressDuration = 1.0;
            [cell.luYinImageView addGestureRecognizer:longPress];
            
            cell.yaJinLabel.linkTextAttributes =@{
                                                  NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                  NSForegroundColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr] ,
                                                  NSUnderlineColorAttributeName:[UIColor colorWithhex16stringToColor:UIColorStr],
                                                  NSFontAttributeName:[UIFont systemFontOfSize:17.0f]
                                                  };
            [cell.yaJinLabel addLinkWithType:MLLinkTypeNone value:@"押金认证" range:NSMakeRange(20, 4)];
            __weak typeof(self) weakSelf = self;
            [cell.yaJinLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
                /** 押金认证执行方法 */
                ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                NSLog(@"点击了押金认证");
            }];
            /*
             NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
             NSRange strRange = {0,[str length]};
             [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
             [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
             [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
             */
            return cell;
        }

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
        //NSData * data = [[ZLLuYinManager shareInstance] dataFromMp3Path];
        //self.voiceBase64String= [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.voiceBase64String = [[ZLLuYinManager shareInstance] base64FromRecordNSData];
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
    if (_isLvYou == YES) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        FaJianZhiLVYouTableViewCell * cell = (FaJianZhiLVYouTableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];
        self.jieShaoString = cell.priceTextField.text;
        self.price = cell.shuoMingTextView.text;

        
        if (self.currentTypeStr.length > 0 && self.jieShaoString.length > 0 && self.voiceBase64String.length > 0 && self.price.length > 0) {
//            [[ZhaoRenFuWuViewModel shareInstance] startTiJiaoAFWorkingWithClass_id:self.currentTypeStr withIntroduce:self.jieShaoString withPrice:self.price withTime:self.time withVoice:self.voiceBase64String withRemark:self.beiZhuStr withBackBlock:^(BOOL success) {
//                if (success == YES) {
//                    [self.navigationController popViewControllerAnimated:YES];
//                }
//            }];
        }
        else{
            [MBManager showBriefAlert:@"请完善信息"];
        }
    }
    else{
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        FaBuJianZhiTableViewCell * cell = (FaBuJianZhiTableViewCell *)[self.tableview cellForRowAtIndexPath:indexPath];
        self.jieShaoString = cell.fuWuJiaGeTextField.text;
        self.price = cell.fuWuJiaGeTextField.text;
        self.time = cell.fuWuShiChangTextField.text;
        self.beiZhuStr = cell.fuWuBeiZhuTextField.text;
        
        if (self.currentTypeStr.length > 0 && self.jieShaoString.length > 0 && self.price.length >0 && self.time.length > 0 && self.voiceBase64String.length > 0) {
            [[ZhaoRenFuWuViewModel shareInstance] startTiJiaoAFWorkingWithClass_id:self.currentTypeStr withIntroduce:self.jieShaoString withPrice:self.price withTime:self.time withVoice:self.voiceBase64String withRemark:self.beiZhuStr withBackBlock:^(BOOL success) {
                if (success == YES) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        else{
            [MBManager showBriefAlert:@"请完善信息"];
        }
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
