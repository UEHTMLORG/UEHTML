//
//  DetailSubPublishViewController.m
//  UEHTML
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "DetailSubPublishViewController.h"

@interface DetailSubPublishViewController (){
    
    /** 当前Model的相册图片数组 */
    NSMutableArray * _albumImageArray;
}

@end

@implementation DetailSubPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兼职详情";
    [self settingTableView];
    /** iOS11.0 处理TableView ScrollView 留白问题 */
    if (@available(iOS 11.0, *)) {
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    /** 开始请求数据并绑定数据 */
    self.viewModel =  [DetailSubPublishViewModel shareInstance];
    __weak typeof(self) weakself = self;
    [self.viewModel startAFNetWorkingGetListWithJobID:self.jobId resultSuccessBlock:^(BOOL success, DetailSubPublishModel *model) {
        weakself.currentModel = model;
        [weakself.tableView reloadData];
    } withFailBlock:^(NSError *error) {
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark ===================关于TableView的所有方法 START==================
- (void)settingTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            return 200.0f;
        }
            break;
        case 1:{
            return 135.0;
        }
            break;
        case 2:{
            CGFloat curHeight = 0;
            if ([self textHeight:self.currentModel.job.introduce] < 20.0) {
                curHeight = 20.0;
            }
            else{
                curHeight = [self textHeight:self.currentModel.job.introduce];
            }
            return 30.0 + 10.0 + curHeight;
        }
            break;
        case 3:{
            return 102.0f;
        }
            break;
        case 4:{
            return 120.0f;
        }
            break;
        case 5:{
            return 30.0f;
        }
            break;
        case 6:{
            return 83.0f;
        }
            break;
        default:
            return 40.0f;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            static NSString * rid = @"DetailXuQiuFirstCellID";
            DetailSubPublishCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][0];
            }
            [cell.leftBackButton addTarget:self action:@selector(leftBackButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.shouCangButton addTarget:self action:@selector(shouCangButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.guanZhuButton addTarget:self action:@selector(guanZhuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.homeButton addTarget:self action:@selector(homeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            /** 相册 */
            if (self.currentModel.album_list.count > 0) {
                _albumImageArray = [NSMutableArray new];
                AlbumMTLModel * firstAlbumModel = self.currentModel.album_list[0];
                [cell.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:firstAlbumModel.picture] placeholderImage:[UIImage imageNamed:DEFAULT_BACKGROUND_IMAGE]];
                /** 添加手势 */
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeadAction:)];
                [tap setNumberOfTapsRequired:1];
                [cell.backgroundImageView addGestureRecognizer:tap];
                
                for (AlbumMTLModel * aModel in self.currentModel.album_list) {
                    UIImageView * imageView = [[UIImageView alloc]init];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:aModel.picture] placeholderImage:[UIImage imageNamed:DEFAULT_BACKGROUND_IMAGE]];
                    [_albumImageArray addObject:imageView];
                }
            }
            /** 相册 结束 */
            cell.juliLabel.text = [NSString stringWithFormat:@"%@km",self.currentModel.distance];
            cell.ageLabel.text = [NSString stringWithFormat:@"%@  %@  %@",self.currentModel.user_profile.age,self.currentModel.user_profile.height,self.currentModel.user_profile.weight];

            return cell;
        }
            break;
        case 1:{
            static NSString * rid = @"DetailXuQiuSecondCellID";
            DetailSubPublishSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][1];
            }
            [cell.chaKanWeiXinButton addTarget:self action:@selector(chaKanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.chengLabel.text = self.currentModel.user_profile.credit_num;
            [cell.voiceButton addTarget:self action:@selector(voiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.priceLabel.text = [NSString stringWithFormat:@"%@ 元/小时 %@小时起",self.currentModel.job.price,self.currentModel.job.service_hourse];
            
            
            return cell;
        }
            break;
        case 2:{
            static NSString * rid = @"DetailXuQiuThirdCellID";
            DetailSubPublishThirdCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][2];
            }
            cell.contentLabel.text = self.currentModel.job.introduce;
            return cell;
        }
            break;
        case 3:{
            static NSString * rid = @"DetailXuQiuFourCellID";
            DetailSubPublishFourCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][3];
            }
            
            return cell;
        }
            break;
        case 4:{
            static NSString * rid = @"DetailXuQiuFiveCellID";
            DetailSubPublishFiveCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][4];
            }
            
            return cell;
        }
            break;
        case 5:{
            static NSString * rid = @"DetailXuQiuSixCellID";
            DetailSubPublishSixCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][5];
            }
            
            return cell;
        }
            break;
        case 6:{
            static NSString * rid = @"DetailXuQiuSevenCellID";
            DetailSubPublishSevenCell * cell = [tableView dequeueReusableCellWithIdentifier:rid];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"DetailSubPublishCell" owner:self options:nil][6];
            }
            
            
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}
#pragma mark ===================关于TableView的所有方法 END==================
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ===================第一行Cell按钮执行方法==================
- (void)guanZhuButtonAction:(UIButton *)sender{
    
}
- (void)shouCangButtonAction:(UIButton *)sender{
    
}
- (void)rightButtonAction:(UIButton *)sender{
    
}
- (void)homeButtonAction:(UIButton *)sender{
    
    
}
- (void)tapHeadAction:(UITapGestureRecognizer *)sender{
    NSLog(@"点击了背景图");
    UIImageView * firstImage = [_albumImageArray objectAtIndex:0];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    DetailSubPublishCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT) imageViewArray:_albumImageArray imageViewContainView:cell.contentView];
    browser.selectedImageView = firstImage;
    [browser show];
}
#pragma mark ===================第二行Cell按钮执行方法==================
- (void)chaKanButtonAction:(UIButton *)sender{
    NSLog(@"点击查看微信");
    //self.currentModel
    [MBManager showBriefAlert:@"微信号数据未提供"];
}
- (void)voiceButtonAction:(UIButton *)sender{
    NSLog(@"点击了播放声音按钮");
    
}
#pragma mark ===================底部按钮执行方法 START==================

- (IBAction)songLiBtnAction:(id)sender {
}
- (IBAction)shipinBtnAction:(id)sender {
}
- (IBAction)liaotianBtnAction:(id)sender {
}
- (IBAction)yueTaBtnAction:(id)sender {
}
#pragma mark ===================底部按钮执行方法 END==================
#pragma mark ===================懒加载==================
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray new];
    }
    return _modelArray;
}


/** 设置状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;//白色
}

/** 返回按钮实现 */
- (void)leftBackButtonAction:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

/** 自适应高度 Label */
-(CGFloat)textHeight:(NSString *)string{
    //传字符串返回高度
    CGRect rect =[string boundingRectWithSize:CGSizeMake(SIZE_WIDTH-50.0, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];//计算字符串所占的矩形区域的大小
    return rect.size.height;//返回高度
    
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
