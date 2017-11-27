//
//  ATQMessageViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "UIButton+Badge.h"
#import "XiTongMsgViewController.h"
#import "MsgLastListView.h"
#import "MessageControllerViewModel.h"
#import "ATQMyFriendsViewController.h"
#import "XiTongZLViewController.h"
@interface ATQMessageViewController : RCConversationListViewController

@property (nonatomic, strong) NSArray<MsgLastZaiXianModel *> *zaiXianArr;

@end
