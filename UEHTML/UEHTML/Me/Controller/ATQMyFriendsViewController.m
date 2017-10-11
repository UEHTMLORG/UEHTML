//
//  ATQMyFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyFriendsViewController.h"
#import "LhkhButton.h"
#import "UIColor+LhkhColor.h"
#import "UIView+LhkhExtension.h"
#import "Masonry.h"
#import "ATQMyFriendsTableViewCell.h"
#import "ATQAddFriendsViewController.h"
@interface ATQMyFriendsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UIView *titlesView;
@property (weak, nonatomic) LhkhButton *selectedButton;
@property (weak, nonatomic) UIView *sliderView;
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQMyFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友345";
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"haoyou-Top tianjia"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriendClick)];
    self.navigationItem.rightBarButtonItem = right;
    [self setupTitlesView];
    [self setTableView];
}

-(void)addFriendClick{
    NSLog(@"---");
    ATQAddFriendsViewController *vc = [[ATQAddFriendsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setupTitlesView{
    //标题数组
    NSArray *titleArr = @[@"好友",@"关注",@"粉丝"];
    //标题栏设置
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.width = ScreenWidth ;
    titlesView.height = 40;
    titlesView.y = 0;
    [self.view addSubview:titlesView];
    
    self.titlesView = titlesView;
    
    // 底部滑条
    UIView *sliderView = [[UIView alloc] init];
    sliderView.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    sliderView.height = 2;
    sliderView.tag = -1;
    sliderView.y = titlesView.height - sliderView.height;
    
    self.sliderView = sliderView;
    
    //设置上面的按钮
    NSInteger width = titlesView.width  / titleArr.count;
    NSInteger height = 30;
    for (NSInteger i=0; i<titleArr.count; i++) {
        LhkhButton *btn = [[LhkhButton alloc] init];
        btn.width = width;
        btn.height = height;
        btn.y = 5;
        btn.x = i * width;
        btn.tag = i;
        [btn setTitle: titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:UIColorStr] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        
        if (i == 0) {
            btn.enabled = NO;
            self.selectedButton = btn;
            [btn.titleLabel sizeToFit];
            self.sliderView.width = btn.width;
            self.sliderView.centerX = btn.centerX;
        }
    }
    [self.titlesView addSubview:sliderView];
}

-(void)setTableView{
    
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMyFriendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMyFriendsTableViewCell"];
        
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
        make.top.mas_equalTo(self.view).offset(40);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

#pragma mark 标题栏每个按钮的点击事件
-(void)titleClick:(LhkhButton *)button{
//    b = button.tag;
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    NSLog(@"%@",self.selectedButton.titleLabel.text);
    [UIView animateWithDuration:0.25 animations:^{
        self.sliderView.width = button.width;
        self.sliderView.centerX = button.centerX;
//        if (button.tag == 0) {
//            _WeChatView.hidden = NO;
//            _tableView.hidden = YES;
//        }else if (button.tag == 1){
//            b = button.tag;
//            _tableView.hidden = NO;
//            _WeChatView.hidden = YES;
//            [self.tableView reloadData];
//        }else{
//            _tableView.hidden = NO;
//            _WeChatView.hidden = YES;
//            [self.tableView reloadData];
//        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 15;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQMyFriendsTableViewCell" ;
    ATQMyFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 30)];
    label.text = @"A";
    label.textColor = [UIColor colorWithHexString:UIColorStr];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

//显示每组标题索引↑↓

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"↑",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"↓"];
}

//返回每个索引的内容

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    return arr[section];
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index{
    NSInteger count = 0;
    NSArray *arr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    for (NSString *character in arr) {
        
        if ([[character uppercaseString] hasPrefix:title]) {
            return count;
        }
        count++;
        NSLog(@"---%@",character);
    }
    return  0;
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
