//
//  ATQVisitorViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQVisitorViewController.h"
#import "ATQVisitorTableViewCell.h"
#import "YAScrollSegmentControl.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
@interface ATQVisitorViewController ()<YAScrollSegmentControlDelegate,UITableViewDelegate,UITableViewDataSource>{
    YAScrollSegmentControl *titleView;
    UIView *blankView;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQVisitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(right)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self buildTitleView];
    [self  buildBlankView];
    [self setTableView];
     blankView.hidden = YES;
}

-(void)buildBlankView{
    blankView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:blankView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
//    imageView.backgroundColor = [UIColor greenColor];
    imageView.image = [UIImage imageNamed:@"my-jiao"];
    [blankView addSubview:imageView];
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectZero];
    lab1.text = @"对不起,您目前无权查看来访者";
    lab1.textColor = [UIColor colorWithHexString:UIColorStr];
    lab1.font = [UIFont systemFontOfSize:14];
    [blankView addSubview:lab1];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [blankView addSubview:view];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    [btn addTarget:self action:@selector(gotoVip) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"立即开通会员" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor colorWithHexString:UIDeepTextColorStr] forState:UIControlStateNormal];
    [view addSubview:btn];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectZero];
    spaceView.backgroundColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [view addSubview:spaceView];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectZero];
    lab2.text = @",查看来访者";
    lab2.font = [UIFont systemFontOfSize:14];
    lab2.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [view addSubview:lab2];
    
    [blankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blankView);
        make.top.equalTo(blankView.mas_top).offset(50);
        make.width.height.offset(120);
    }];
    
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(blankView);
        make.top.equalTo(imageView.mas_bottom).offset(20);
        make.height.offset(30);
    }];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab1.mas_bottom).offset(5);
        make.left.equalTo(lab1.mas_left).offset(10);
        make.right.equalTo(lab1.mas_right).offset(-10);
        make.centerX.equalTo(blankView);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(view);
        make.right.equalTo(lab2.mas_left).offset(0);
    }];
    
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.equalTo(btn.mas_left);
        make.width.equalTo(btn.mas_width);
        make.bottom.equalTo(btn.mas_bottom).offset(-5);
    }];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(view);
        make.left.equalTo(btn.mas_right).offset(0);
    }];
}

-(void)buildTitleView{
    titleView = [[YAScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-50, 40)];
    titleView.delegate = self;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.tintColor = [UIColor clearColor];
    titleView.buttons = @[@"来访者",@"我看过的人"];
    [titleView setTitleColor:[UIColor colorWithHexString:@"FFE010"] forState:UIControlStateSelected];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleView.selectedIndex = 0;
    self.navigationItem.titleView = titleView;
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQVisitorTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQVisitorTableViewCell"];
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
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQVisitorTableViewCell" ;
    ATQVisitorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    return 60;
}

-(void)gotoVip{
    NSLog(@"gotoVip");
}

-(void)right{
    
}

#pragma mark- YAScrollSegmentControlDelegate
-(void)didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"点击了%ld",index);
    if (titleView.selectedIndex == index) {
        return;
    }else{
        if (index == 0) {
            NSLog(@"点击了来访者");
        }else{
            NSLog(@"点击了我看过的人");
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
