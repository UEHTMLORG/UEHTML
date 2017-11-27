//
//  XiTongZLViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/27.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "XiTongZLViewController.h"

@interface XiTongZLViewController ()

@end

@implementation XiTongZLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self.tableview registerNib:[UINib nibWithNibName:@"XiTongMsgTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"XiTongCellID"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setRightButton];
}
- (void)setRightButton{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)rightButtonAction:(UIButton *)sender{
    [self.array removeAllObjects];
    [self.tableview reloadData];
}

#pragma mark ===================TableView设置==================
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"XiTongCellID";
    XiTongMsgTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rid forIndexPath:indexPath];
    
    
    return cell;
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray new];
        [_array addObjectsFromArray:@[@"d",@"d",@"d"]];
    }
    return _array;
}

#pragma mark ===================TableView设置结束==================

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
