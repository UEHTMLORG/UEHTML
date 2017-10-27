//
//  ATQMyselfViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMyselfViewController.h"
#import "ATQMePublishViewController.h"
#import "ATQDataSource.h"
#import "ATQMeTableViewCell.h"
#import "ATQMePublishTableViewCell.h"
#import "ATQCommentModel.h"
#import "ATQPYQModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ZJImageViewBrowser.h"
#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
#import "Masonry.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface ATQMyselfViewController ()<ATQMeCellDelegate,ChatKeyBoardDelegate, ChatKeyBoardDataSource,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic,strong)NSIndexPath *commentIndexpath;
@property (nonatomic,strong)NSIndexPath *replyIndexpath;
@property (nonatomic,assign)float totalKeybordHeight;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQMyselfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [ATQDataSource loadDataArray].mutableCopy;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self setTableView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //        __weak typeof(self) weakSelf = self;
    //        [self.tableView addRefreshHeaderViewWithCallback:^{
    //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //                weakSelf.dataArray = [DataSourceManager loadDataArray].mutableCopy;
    //                [weakSelf.tableView reloadData];
    //                [weakSelf.tableView headerEndRefreshing];
    //            });
    //        }];
    
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
        [tableView registerNib:[UINib nibWithNibName:@"ATQMePublishTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMePublishTableViewCell"];
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
    return self.dataArray.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else{
        float h =  [ATQMeTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            ATQMeTableViewCell *cell = (ATQMeTableViewCell *)sourceCell;
            [self  configureCell:cell atIndexPath:indexPath];
        }];
        return h;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakself = self;
    if (indexPath.row == 0) {
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
        ATQMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATQMeTableViewCell"];
        if(cell==nil)
        {
            cell = [[ATQMeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATQMeTableViewCell"];
            cell.delegate = self;
        }
        cell.backgroundColor = [UIColor whiteColor];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
}
- (void)configureCell:(ATQMeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell configCellWithModel:self.dataArray[indexPath.row-1] indexPath:indexPath];
}
#pragma mark -- FriendLineCellDelegate
#pragma mark -- 点击全文、收起
-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
{
    ATQPYQModel *model = self.dataArray[indexPath.row-1];
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
    if (indexPath.row == 0) {
        
    }else{
        ATQPYQModel *model = self.dataArray[indexPath.row];
        NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
        model.isLiked ==YES ? [likeArray removeObject:@"Sky"]:[likeArray addObject:@"Sky"];
        
        model.likeNameArray = [likeArray copy];
        model.isLiked = !model.isLiked;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}
#pragma mark -- 点击评论按钮
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath
{
    self.commentIndexpath = indexPath;
    ATQPYQModel *model = self.dataArray[indexPath.row-1];
    self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论：%@",model.usernName];
    [self.chatKeyBoard keyboardUpforComment];
}
#pragma mark --点击评论内容的某一行
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
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
    ATQPYQModel *model = self.dataArray[self.commentIndexpath.row-1];
    
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
}

//更换头像
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
