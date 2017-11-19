//
//  ATQPublishAddrViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/11/19.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQPublishAddrViewController.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "ATQAddressCell.h"
@interface ATQPublishAddrViewController ()<UITableViewDelegate,UITableViewDataSource,ATQPublishAddrViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQPublishAddrViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"-----%ld",_addrArr.count);
    [self setTableView];
}


#pragma mark - Layout SubViews




#pragma mark - System Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addrArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQAddressCell" ;
    ATQAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.addrLab.text = _addrArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *addr = _addrArr[indexPath.row];
    if ([_delegate respondsToSelector:@selector(ATQPublishAddrViewControllerDelegate:)]) {
        [_delegate ATQPublishAddrViewControllerDelegate:addr];
        [self.navigationController popViewControllerAnimated: NO];
    }
}

#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        [tableView registerNib:[UINib nibWithNibName:@"ATQAddressCell" bundle:nil] forCellReuseIdentifier:@"ATQAddressCell"];
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


#pragma mark - Getters and Setters



@end

