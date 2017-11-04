//
//  ATQMyselfViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyselfViewController.h"
#import "ATQMePublishViewController.h"
#import "ATQMePublishTableViewCell.h"
#import "Masonry.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface ATQMyselfViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishTableViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //    [self.tableView.mj_header beginRefreshing];
    //    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(60);
        make.bottom.mas_equalTo(self.view).offset(-54);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakself = self;
    static NSString *CellIdentifier = @"ATQMePublishTableViewCell" ;
    ATQMePublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.publishblock = ^{

        [weakself selectImage];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//发布动态
-(void)selectImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"发布动态" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从手机相册选择",@"纯文字动态", nil];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    view.backgroundColor = [UIColor redColor];
    [sheet insertSubview:view atIndex:2];
    [sheet showInView:self.view];
}

#pragma UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"====0000");
        NSString *typestr = [NSString stringWithFormat:@"%ld",buttonIndex];
        ATQMePublishViewController *vc = [[ATQMePublishViewController alloc] init];
        vc.typeStr = typestr;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (buttonIndex == 1){
        NSLog(@"====1111");
        NSString *typestr = [NSString stringWithFormat:@"%ld",buttonIndex];
        ATQMePublishViewController *vc = [[ATQMePublishViewController alloc] init];
        vc.typeStr = typestr;
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if (buttonIndex == 2){
        NSLog(@"====2222");
        NSString *typestr = [NSString stringWithFormat:@"%ld",buttonIndex];
        ATQMePublishViewController *vc = [[ATQMePublishViewController alloc] init];
        vc.typeStr = typestr;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        NSLog(@"cancel");
    }
}

-(void)dealloc
{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
