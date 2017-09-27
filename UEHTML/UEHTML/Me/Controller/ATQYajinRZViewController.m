//
//  ATQYajinRZViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQYajinRZViewController.h"
#import "ATQYJRZTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIColor+LhkhColor.h"
@interface ATQYajinRZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQYajinRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"押金认证";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQYJRZTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQYJRZTableViewCell"];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQYJRZTableViewCell" ;
    ATQYJRZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin"];
        cell.lvLab.text = @"平民";
        cell.lvMoney.text = @"￥1000";
    }else if (indexPath.row == 1) {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin02"];
        cell.lvLab.text = @"商人";
        cell.lvMoney.text = @"￥2000";
    }else if (indexPath.row == 2) {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin03"];
        cell.lvLab.text = @"财主";
        cell.lvMoney.text = @"￥3000";
    }else if (indexPath.row == 3) {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin04"];
        cell.lvLab.text = @"知县";
        cell.lvMoney.text = @"￥4000";
    }else if (indexPath.row == 4) {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin05"];
        cell.lvLab.text = @"总督";
        cell.lvMoney.text = @"￥5000";
    }else {
        cell.lvImg.image = [UIImage imageNamed:@"renzheng-yajin06"];
        cell.lvLab.text = @"帝主";
        cell.lvMoney.text = @"￥6000";
    }
    cell.renzhengblock = ^{
        NSLog(@"认证%ld",indexPath.row);
    };
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
