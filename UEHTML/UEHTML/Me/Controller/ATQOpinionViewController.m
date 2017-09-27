//
//  ATQOpinionViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQOpinionViewController.h"
#import "ATQQuesTableViewCell.h"
#import "ATQOpinionTableViewCell.h"
#import "ATQOpinionPhotoTableViewCell.h"
#import "ATQSZLoginOutTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "KZPhotoManager.h"
@interface ATQOpinionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQQuesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQQuesTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQOpinionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQOpinionTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQOpinionPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQOpinionPhotoTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZLoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZLoginOutTableViewCell"];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ATQQuesTableViewCell" ;
        ATQQuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section ==1){
        static NSString *CellIdentifier = @"ATQOpinionTableViewCell" ;
        ATQOpinionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQOpinionPhotoTableViewCell" ;
        ATQOpinionPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.xuanZeTuPianBlock = ^(){//选择图片
            [KZPhotoManager getImage:^(UIImage *image) {
                ATQOpinionPhotoTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                [cell.imgsArray insertObject:image atIndex:0];
                [cell.photoCollectionView reloadData];
            } showIn:weakself AndActionTitle:@"请选择照片"];
        };
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQSZLoginOutTableViewCell" ;
        ATQSZLoginOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.loginOutBtn setTitle:@"提交" forState:UIControlStateNormal];
        cell.loginoutblock = ^{
            NSLog(@"提交");
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        return 150;
    }else if (indexPath.section == 2){
        return 140;
    }else{
        return 80;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 3) {
        
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 3) {
        return 0;
    }else{
        return 10;
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
