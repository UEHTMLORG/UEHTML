//
//  ATQSearchFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSearchFriendsViewController.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "ATQNewFriendsTableViewCell.h"
@interface ATQSearchFriendsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    UITextField *searchText;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQSearchFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNaviView];
    [self setTableView];
}

-(void)buildNaviView{
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightBack)];
    self.navigationItem.rightBarButtonItem = right;
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 30)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 4.f;
    mainView.layer.masksToBounds = YES;
    self.navigationItem.titleView = mainView;
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    searchImg.image = [UIImage imageNamed:@"haoyou-chazhao"];
    [mainView addSubview:searchImg];
    [searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(20);
        make.left.equalTo(mainView.mas_left).offset(5);
        make.centerY.equalTo(mainView.mas_centerY);
    }];
    searchText = [[UITextField alloc]initWithFrame:CGRectZero];
    searchText.placeholder = @"请输入凹凸圈ID";
    searchText.text = self.searchStr;
    searchText.font = [UIFont systemFontOfSize:14];
    searchText.textColor = [UIColor colorWithHexString:@"959697"];
    searchText.tintColor = [UIColor blueColor];
    searchText.returnKeyType = UIReturnKeySearch;
    searchText.enablesReturnKeyAutomatically = YES;
    searchText.delegate = self;
    searchText.enabled = YES;
    [mainView addSubview:searchText];
    [searchText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImg.mas_right).offset(5);
        make.top.bottom.equalTo(mainView);
    }];
    UIButton *chaBtn = [[UIButton  alloc] initWithFrame:CGRectZero];
    [chaBtn setImage:[UIImage imageNamed:@"haoyou-cha"] forState:UIControlStateNormal];
    [chaBtn addTarget:self action:@selector(qingchuClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:chaBtn];
    [chaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(15);
        make.left.equalTo(searchText.mas_right).offset(5);
        make.right.equalTo(mainView).offset(-5);
        make.centerY.equalTo(mainView.mas_centerY);
    }];
}

-(void)setTableView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQNewFriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQNewFriendsTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.sectionIndexColor = [UIColor blackColor];
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        tableView.sectionIndexTrackingBackgroundColor = [UIColor colorWithHexString:UIColorStr];
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
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQNewFriendsTableViewCell" ;
    ATQNewFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.addfriendsblock = ^{
        NSLog(@"add");
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)rightBack{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)qingchuClick{
    NSLog(@"----");
    searchText.text = @"";
    [searchText becomeFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"++++%@",textField.text);
    [searchText resignFirstResponder];
    return YES;
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
