//
//  JianZhiChuFaViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/13.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiChuFaViewController.h"

@interface JianZhiChuFaViewController ()

@end

@implementation JianZhiChuFaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"处罚名单";
    // Do any additional setup after loading the view from its nib.
}

#pragma mark ===================UITableViewDelegate方法==================
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"JianZhiChuFaCellID";
    
    JianZhiChuFaTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
//        cell=[[JianZhiChuFaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        cell = [[NSBundle mainBundle] loadNibNamed:@"JianZhiChuFaTableViewCell" owner:self options:nil][0];
    }
    
    return cell;
    
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
