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
#import "ATQMeDTTableViewCell.h"
#import "Masonry.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "LhkhHttpsManager.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Add.h"
#import "ATQDTModel.h"
#import "ATQContentModel.h"
#import "ATQDTImageView.h"
#import "ZJImageViewBrowser.h"
#import "NSString+ZJ.h"

#import "ChatKeyBoard.h"
#import "FaceSourceManager.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceThemeModel.h"

@interface ATQMyselfViewController ()<ChatKeyBoardDelegate, ChatKeyBoardDataSource,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,ATQMeDTTableViewCellDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *MeDTArr;
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, assign) BOOL isShowKeyBoard;

@end
static NSInteger page = 1;
@implementation ATQMyselfViewController

- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    return @[item1];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}
-(ChatKeyBoard *)chatKeyBoard{
    if (_chatKeyBoard==nil) {
        _chatKeyBoard =[ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.placeHolder = @"评论";
        [self.view addSubview:_chatKeyBoard];
        [self.view bringSubviewToFront:_chatKeyBoard];
    }
    return _chatKeyBoard;
}

- (void)chatKeyBoardSendText:(NSString *)text{
    
    [self.chatKeyBoard keyboardDownForComment];
    self.chatKeyBoard.placeHolder = nil;
    
}
- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceStyle:(NSInteger)faceStyle faceName:(NSString *)faceName delete:(BOOL)isDeleteKey{
    NSLog(@"%@",faceName);
}
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册键盘出现NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘隐藏NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    [self setTableView];
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = @"3";
    params[@"page_index"] = @"1";
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/circle/index",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----circle=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [_MeDTArr removeAllObjects];
            if(responseObject[@"data"]){
                _MeDTArr = [ATQDTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            }
            [self.tableView reloadData];
                
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
}

-(void)loadMoreData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = @"1";
    params[@"page_index"] = [NSString stringWithFormat:@"%ld",page];
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/circle/index",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----circle=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                [_MeDTArr addObjectsFromArray:[ATQDTModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
            }
            [self.tableView reloadData];
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
    
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
        [tableView registerClass:[ATQMeDTTableViewCell class] forCellReuseIdentifier:@"ATQMeDTTableViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [self loadMoreDataFooterWith:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(60);
        make.bottom.mas_equalTo(self.view).offset(-54);
    }];
    
}
-(MJRefreshAutoNormalFooter *)loadMoreDataFooterWith:(UIScrollView *)scrollView {
    MJRefreshAutoNormalFooter *loadMoreFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
        page++;
        [scrollView.mj_footer endRefreshing];
    }];
    
    return loadMoreFooter;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return _MeDTArr.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else{
        ATQDTModel *model = nil;
        if (_MeDTArr.count>0) {
            model = _MeDTArr[indexPath.row];
        }
        float msgHeight = [NSString stringHeightWithString:model.desc size:14 maxWidth: ScreenWidth-80];
        if (msgHeight >60) {
            msgHeight = 90;
        }
        float imageContainViewHeight;
        if(model.pictures.count==0)
        {
            imageContainViewHeight = 0;
        }
        else if (model.pictures.count>0 && model.pictures.count<4)
        {
            imageContainViewHeight = (ScreenWidth-90)/3;
        }
        else
        {
            imageContainViewHeight = (2*(ScreenWidth-90)/3)+5;
        }
        float btnHeight;
        if (model.isExpand) {
            btnHeight = 40;
            msgHeight = [NSString stringHeightWithString:model.desc size:14 maxWidth: ScreenWidth-80];
        }else{
            btnHeight = 0;
        }
        float pinglunHeight = 0;
        NSArray *arr =  [ATQContentModel mj_objectArrayWithKeyValuesArray:model.message_list];
        
        float pinglunMsgH = 0;
        if (arr.count>0) {
            for (ATQContentModel *conmodel in arr) {
                pinglunMsgH = [NSString stringHeightWithString:conmodel.message size:12 maxWidth: ScreenWidth-80];
                pinglunHeight += pinglunMsgH+35;
            }
        }else{
            pinglunHeight = 10;
        }
        return 40+msgHeight+imageContainViewHeight+pinglunHeight+btnHeight;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakself = self;
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ATQMePublishTableViewCell" ;
        ATQMePublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.publishblock = ^{
            
            [weakself selectImage];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQMeDTTableViewCell" ;
        ATQMeDTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        ATQDTModel *model = nil;
        if (_MeDTArr.count>0) {
            model = _MeDTArr[indexPath.row];
        }
        cell.delegate = self;
        [cell configCellWithModel:model indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark -- ATQMeDTTableViewCellDelegate
#pragma mark -- 点击全文、收起
-(void)didClickMeMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
{
    ATQDTModel *model = self.DTArr[indexPath.row];
    model.isExpand = !model.isExpand;
    
    [self.tableView reloadData];
}
#pragma mark -- 图片
-(void)didClickMeImageViewWithCurrentCell:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath{
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageViewArray:array imageViewContainView:view];
    browser.selectedImageView = imageView;
    [browser show];
}

#pragma mark -- 删除
-(void)didClickMeDelWithIndexPath:(NSIndexPath *)indexPath{
    ATQDTModel *model = self.DTArr[indexPath.row];
    [self delClick:model.ID];
}

#pragma mark -- 花
-(void)didClickMeHuaWithIndexPath:(NSIndexPath *)indexPath{
    ATQDTModel *model = self.DTArr[indexPath.row];
    [self songHuaClick:model.ID];
}

#pragma mark -- 评论
-(void)didClickCommentWithIndexPath:(NSIndexPath *)indexPath{
    [self.chatKeyBoard keyboardUpforComment];
}

-(void)delClick:(NSString*)cid{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"cid"] = cid;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/circle/delete",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----delete=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            [self loadData];
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
}

-(void)songHuaClick:(NSString*)cid{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"cid"] = cid;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/circle/flower",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"-----flower=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            [self loadData];
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
    }];
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
-(NSMutableArray*)DTArr{
    if (_MeDTArr == nil) {
        _MeDTArr = [NSMutableArray array];
    }
    return _MeDTArr;
}

#pragma mark keyboardWillShow
- (void)keyboardWillShow:(NSNotification *)notification
{
    self.isShowKeyBoard = YES;
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    __block  CGFloat keyboardHeight = [aValue CGRectValue].size.height;
    if (keyboardHeight==0) {
        //解决搜狗输入法三次调用此方法的bug、
        //        IOS8.0之后可以安装第三方键盘，如搜狗输入法之类的。
        //        获得的高度都为0.这是因为键盘弹出的方法:- (void)keyBoardWillShow:(NSNotification *)notification需要执行三次,你如果打印一下,你会发现键盘高度为:第一次:0;第二次:216:第三次:282.并不是获取不到高度,而是第三次才获取真正的高度.
        return;
    }
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat delta = 0.0;
    //    if (self.seletedCellHeight){//点击某行row，进行回复某人
    //        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-self.seletedCellHeight-kChatToolBarHeight-2);
    //    }else{//点击评论按钮
    //        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-kChatToolBarHeight-24-10);//24为评论按钮高度，10为评论按钮上部的5加评论按钮下部的5
    //    }
    //    CGPoint offset = self.tableView.contentOffset;
    //    offset.y += delta;
    //    if (offset.y < 0) {
    //        offset.y = 0;
    //    }
    //    if (self.needUpdateOffset) {
    //        [self.tableView setContentOffset:offset animated:YES];
    //    }
}
#pragma mark
#pragma mark keyboardWillHide
- (void)keyboardWillHide:(NSNotification *)notification {
        self.isShowKeyBoard = NO;
    //    self.needUpdateOffset = NO;
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
