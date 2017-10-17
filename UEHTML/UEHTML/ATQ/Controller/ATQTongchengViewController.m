//
//  ATQTongchengViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTongchengViewController.h"
#import "ATQDataSource.h"
#import "ATQPYQTableViewCell.h"
#import "ATQCommentModel.h"
#import "ATQPYQModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ZJImageViewBrowser.h"
#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
#import "Masonry.h"
@interface ATQTongchengViewController ()<ATQPYQCellDelegate,ChatKeyBoardDelegate, ChatKeyBoardDataSource,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic,strong)NSIndexPath *commentIndexpath;
@property (nonatomic,strong)NSIndexPath *replyIndexpath;
@property (nonatomic,assign)float totalKeybordHeight;
@property (nonatomic,strong)UITableView *tableView;


@end

@implementation ATQTongchengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [ATQDataSource loadDataArray].mutableCopy;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setTableView];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        
    _chatKeyBoard =[ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _chatKeyBoard.delegate = self;
    _chatKeyBoard.dataSource = self;
    _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    _chatKeyBoard.allowVoice = NO;
    _chatKeyBoard.allowMore = NO;
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    [window addSubview:_chatKeyBoard];
        
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
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
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float h =  [ATQPYQTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ATQPYQTableViewCell *cell = (ATQPYQTableViewCell *)sourceCell;
        [self  configureCell:cell atIndexPath:indexPath];
    }];
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATQPYQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATQPYQTableViewCell"];
    if(cell==nil)
    {
        cell = [[ATQPYQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATQPYQTableViewCell"];
        cell.delegate = self;
    }
    cell.backgroundColor = [UIColor whiteColor];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(ATQPYQTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell configCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
}
#pragma mark -- FriendLineCellDelegate
#pragma mark -- 点击全文、收起
-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
{
    ATQPYQModel *model = self.dataArray[indexPath.row];
    model.isExpand = !model.isExpand;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -- 点击图片
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath
{
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageViewArray:array imageViewContainView:view];
    browser.selectedImageView = imageView;
    [browser show];
}
#pragma mark -- 点击赞
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath
{
    ATQPYQModel *model = self.dataArray[indexPath.row];
    NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    model.isLiked ==YES ? [likeArray removeObject:@"Sky"]:[likeArray addObject:@"Sky"];
    
    model.likeNameArray = [likeArray copy];
    model.isLiked = !model.isLiked;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark -- 点击评论按钮
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath
{
    
    self.commentIndexpath = indexPath;
    ATQPYQModel *model = self.dataArray[indexPath.row];
    self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论：%@",model.usernName];
    [self.chatKeyBoard keyboardUpforComment];
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark --点击评论内容的某一行
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
    self.tabBarController.tabBar.hidden = YES;
    ATQPYQModel *model = self.dataArray[firIndexPath.row];
    ATQCommentModel *comModel = model.commentArray[secIndexPath.row];
    if([comModel.userName isEqualToString:@"Sky"])
    {
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil  message:@"是否删除该条评论" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray *mutableArray = model.commentArray.mutableCopy;
            [mutableArray removeObjectAtIndex:secIndexPath.row];
            model.commentArray = mutableArray.copy;
            [self.tableView reloadRowsAtIndexPaths:@[firIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        [controller addAction:cancelAction];
        [controller addAction:okAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        self.commentIndexpath = firIndexPath;
        self.replyIndexpath = secIndexPath;
        
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复：%@",comModel.userName];
        [self.chatKeyBoard keyboardUpforComment];
    }
    
}
#pragma mark -- ChatKeyBoardDelegate
- (void)chatKeyBoardSendText:(NSString *)text;
{
    ATQPYQModel *model = self.dataArray[self.commentIndexpath.row];
    
    ATQCommentModel *newComModel = [[ATQCommentModel alloc] init];
    newComModel.userName = @"Sky";
    if(self.replyIndexpath)
    {
        ATQCommentModel *comModel = model.commentArray[self.replyIndexpath.row];
        newComModel.replyUserName = comModel.userName;
    }
    newComModel.content = text;
    
    
    NSMutableArray *mutableArray = model.commentArray.mutableCopy;
    [mutableArray addObject:newComModel];
    model.commentArray = mutableArray.copy;
    
    [self.tableView reloadRowsAtIndexPaths:@[self.commentIndexpath] withRowAnimation:UITableViewRowAnimationFade];
    self.replyIndexpath = nil;
    [self.chatKeyBoard keyboardDownForComment];
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    return nil;
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    return @[item1];
}
- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}

- (void)keyboardWillChangeNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(rect.origin.y<ScreenHeight)
    {
        self.totalKeybordHeight  = rect.size.height + 49;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.commentIndexpath];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //坐标转换
        CGRect rect = [cell.superview convertRect:cell.frame toView:window];
        
        CGFloat dis = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
        CGPoint offset = self.tableView.contentOffset;
        offset.y += dis;
        if (offset.y < 0) {
            offset.y = 0;
        }
        
        [self.tableView setContentOffset:offset animated:YES];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDownForComment];
    self.tabBarController.tabBar.hidden = NO;
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
