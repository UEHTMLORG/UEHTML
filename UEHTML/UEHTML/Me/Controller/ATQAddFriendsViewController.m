//
//  ATQAddFriendsViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQAddFriendsViewController.h"
#import "ATQSearchFriendsViewController.h"
#import "ATQNewFriendsTableViewCell.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
@interface ATQAddFriendsViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQAddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"好友";
    [self buildSousuoView];
    [self setTableView];
}

-(void)buildSousuoView{
    self.sousuoView.layer.cornerRadius = 4.f;
    self.sousuoView.layer.masksToBounds = YES;
    self.sousuoView.layer.borderWidth = 1.f;
    self.sousuoView.layer.borderColor = [UIColor colorWithHexString:UIBgColorStr].CGColor;
    self.sousuoText.returnKeyType = UIReturnKeySearch;
    self.sousuoText.enablesReturnKeyAutomatically = YES;
    self.sousuoText.delegate = self;
    self.sousuoText.enabled = YES;
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
        make.top.mas_equalTo(self.view).offset(40);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"++++%@",textField.text);
    ATQSearchFriendsViewController *vc = [[ATQSearchFriendsViewController alloc] init];
    vc.searchStr = textField.text;
    [self.navigationController pushViewController:vc animated:YES];
    [self.sousuoText resignFirstResponder];
    return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 30)];
    label.text = @"新的朋友";
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
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
