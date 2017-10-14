//
//  XiTongMsgViewController.m
//  UEHTML
//
//  Created by apple on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "XiTongMsgViewController.h"

@interface XiTongMsgViewController ()

@end

@implementation XiTongMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统通知";
    // Do any additional setup after loading the view.
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {

        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = @"用户名2";
        [self.navigationController pushViewController:conversationVC animated:YES];
    
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
