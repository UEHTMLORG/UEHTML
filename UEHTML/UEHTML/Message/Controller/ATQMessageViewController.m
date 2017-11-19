//
//  ATQMessageViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMessageViewController.h"

@interface ATQMessageViewController (){
    
    MsgLastListView * _lastView;
    
}

@end

@implementation ATQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP),
                                          @(ConversationType_SYSTEM)]];
   
    //基本属性
//    self.cellBackgroundColor = [UIColor yellowColor];//cell的背景颜色
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];//设置头像显示方法
    self.view.backgroundColor = [UIColor colorWithhex16stringToColor:Light_Gray_Color];
    
    [self loadLeftRightButton];
    [self loadLastZaiXianView];
    
    [self.conversationListTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(195);
    }];
    /** tableviews设置 */
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.emptyConversationView = [[UIView alloc]init];
}



//cell即将显示的方法
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    //修改昵称颜色
    RCConversationModel * model = self.conversationListDataSource[indexPath.row];
    if (model.conversationType == ConversationType_PRIVATE) {
        RCConversationCell * conversationCell = (RCConversationCell *)cell;
        conversationCell.conversationTitle.textColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
//        [conversationCell setHeaderImagePortraitStyle:RC_USER_AVATAR_CYCLE];
    }
   RCUserInfo * userInfo = [[RCIM sharedRCIM] getUserInfoCache:model.targetId];
    NSLog(@"用户UserID：%@,用户name：%@,头像：%@",userInfo.userId,userInfo.name,userInfo.portraitUri);
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_COLLECTION) {
        XiTongMsgViewController * xiTongVC = [[XiTongMsgViewController alloc]init];
        NSArray * typeARR = [NSArray arrayWithObject:[NSNumber numberWithInteger:model.conversationType]];
        [xiTongVC setDisplayConversationTypeArray:typeARR];
        [xiTongVC setCollectionConversationType:nil];
        xiTongVC.isEnteredToCollectionViewController = YES;//是否进入聚合页列表
        
        [self.navigationController pushViewController:xiTongVC animated:YES];
    }
    else{
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = @"用户名2";
        [self.navigationController pushViewController:conversationVC animated:YES];
        
    }

    /*
     //新建一个聊天会话View Controller对象,建议这样初始化
     RCConversationViewController *chat = [RCConversationViewController alloc] initWithConversationType:conversationType
     targetId:targetId];
     
     //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
     chat.conversationType = ConversationType_PRIVATE;
     //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
     chat.targetId = @"targetIdYouWillChatIn";
     
     //设置聊天会话界面要显示的标题
     chat.title = @"想显示的会话标题";
     //显示聊天会话界面
     [self.navigationController pushViewController:chat animated:YES];
     */
}

//加载 最近在线 视图
- (void)loadLastZaiXianView{
    
    _lastView = [[MsgLastListView alloc]init];

    [self.view addSubview:_lastView];
    [_lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(130.0f);
    }];
}

/** 创建左边按钮 右边 */
- (void)loadLeftRightButton{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0, 0, 19, 19)];
    [leftBtn addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxi-ling"] forState:UIControlStateNormal];
    //[leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    leftBtn.badgeValue = @"5";
    leftBtn.badgeBGColor = [UIColor whiteColor];
    leftBtn.badgeTextColor = [UIColor colorWithhex16stringToColor:Main_Purple_Color];
    leftBtn.badgeOriginX = 5.0f;
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftItem setStyle:UIBarButtonItemStyleDone];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, 0, 19, 19)];
    [rightBtn addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxi-ren"] forState:UIControlStateNormal];
    //[rightBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)leftButtonAction{
    
    
}
- (void)rightButtonAction{
    
    
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
