//
//  ZhaoRenFuWuViewController.h
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "FaBuFirstTableViewCell.h"
#import "FaBuJianZhiTableViewCell.h"
#import "ZLLuYinManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ATQYajinRZViewController.h"
#import "FaJianZhiLVYouTableViewCell.h"
#import "ZhaoRenFuWuViewModel.h"

@interface ZhaoRenFuWuViewController : ATQBaseViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, copy) NSString *currentTypeStr;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *beiZhuStr;
@property (nonatomic, copy) NSString *jieShaoString;
@property (nonatomic, copy) NSString *voiceBase64String;

@end
