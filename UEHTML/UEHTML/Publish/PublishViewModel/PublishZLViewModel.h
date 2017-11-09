//
//  PublishZLViewModel.h
//  UEHTML
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JianZhiListCellModel.h"
@class ATQPublishViewController;

/** 服务方推荐请求，全部订单请求。需求方推荐，全部订单请求 枚举 */
typedef NS_ENUM(NSUInteger, PublishNetWorking_enum) {
    FUWUFANG_TUIJIAN,
    XUQIUFANG_TUIJIAN,
    FUWUFANG_MYLIST,
    XUQIUFANG_MYLIST,
    FUWUFANG_DOING,
    XUQIUFANG_DOING,
    FUWUFANG_FINISHED,
    XUQIUFANG_FINISHED,
};
/** 返回解析好的数据模型数组 */
typedef void(^GetPublishModelArrayBlock)(PublishNetWorking_enum typeEnum,NSMutableArray * array);


@interface PublishZLViewModel : NSObject


@property (nonatomic, strong) ATQPublishViewController *myController;
@property (nonatomic, assign) PublishNetWorking_enum currentNetWorkingType;

@property (nonatomic, strong) NSMutableArray * fuWuMyListArray;
@property (nonatomic, strong) NSMutableArray * fuWuTuiJIanArray;
@property (nonatomic, strong) NSMutableArray * fuWuDoingListArray;
@property (nonatomic, strong) NSMutableArray * fuWuFinishedArray;
@property (nonatomic, strong) NSMutableArray * xuQiuMyListArray;
@property (nonatomic, strong) NSMutableArray * xuQiuTuiJianArray;
@property (nonatomic, strong) NSMutableArray * xuQiuDoingListArray;
@property (nonatomic, strong) NSMutableArray * XuQiuFinishedArray;

@property (nonatomic, assign) NSInteger curFuWuALLListPage;
@property (nonatomic, assign) NSInteger curFuWuDoingListPage;
@property (nonatomic, assign) NSInteger curFuWuFinishListPage;
@property (nonatomic, assign) NSInteger curXuQiuALLListPage;
@property (nonatomic, assign) NSInteger curXuQiuDoingListPage;
@property (nonatomic, assign) NSInteger curXuQiuFinishListPage;
@property (nonatomic, strong) NSMutableArray * currentListArray;

@property (nonatomic, copy) GetPublishModelArrayBlock getblock;

/** 单例创建对象 */
+ (PublishZLViewModel *)shareInstance;
/** 请求网络数据 */
- (void)startAFNetWorkingGetListWithType:(PublishNetWorking_enum )type withPage:(NSInteger )page;

- (void)getPublishModelArrayBlockAction:(GetPublishModelArrayBlock )block;


@end
