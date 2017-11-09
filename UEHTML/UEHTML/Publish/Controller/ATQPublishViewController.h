//
//  ATQPublishViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "ComplainViewController.h"
#import "ATQPHeaderView.h"
#import <DZNSegmentedControl.h>
#import "JianZhiListTableVIew.h"
#import "JianZhiVideoViewController.h"

#import "JianZhiChuFaViewController.h"
#import "JianZhiPingJiaViewController.h"
#import "JianZhiTouSuViewController.h"

#import "ZhaoRenFuWuViewController.h"
#import "WoYaoZhuanViewController.h"

#import "PublishZLViewModel.h"

typedef NS_ENUM(NSUInteger, CURRENTBUTTON_INDEX) {
    ZHAOREN_FUWU_INDEX,
    WOYAO_ZHUANQIAN_INDEX,
};

@interface ATQPublishViewController : ATQBaseViewController<DZNSegmentedControlDelegate,UIScrollViewDelegate,JianZhiHeaderViewDelegate>

@property (nonatomic, strong) UIView *tiGongView;
@property (nonatomic, strong) UIView *tiGongSubView;
@property (nonatomic, strong) UIView *yiYaoView;
@property (nonatomic, strong) DZNSegmentedControl *yiYaoControl;
@property (nonatomic, strong) DZNSegmentedControl *tiGongControl;
@property (nonatomic, strong) DZNSegmentedControl *tiGongSubControl;
@property (nonatomic, strong) NSArray *firstItemARR;
@property (nonatomic, strong) NSArray *secondItemARR;
@property (nonatomic, strong) NSArray *thirdItemARR;
@property (nonatomic, strong) JianZhiListTableVIew *listView;
@property (nonatomic, assign) CURRENTBUTTON_INDEX currentButtonIndex;
@property (nonatomic, strong) PublishZLViewModel *myViewModel;

@property (nonatomic, assign) NSInteger curFuWuALLListPage;
@property (nonatomic, assign) NSInteger curFuWuDoingListPage;
@property (nonatomic, assign) NSInteger curFuWuFinishListPage;
@property (nonatomic, assign) NSInteger curXuQiuALLListPage;
@property (nonatomic, assign) NSInteger curXuQiuDoingListPage;
@property (nonatomic, assign) NSInteger curXuQiuFinishListPage;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray * currentListArray;
@property (nonatomic, assign) PublishNetWorking_enum currentPageType;

@end
