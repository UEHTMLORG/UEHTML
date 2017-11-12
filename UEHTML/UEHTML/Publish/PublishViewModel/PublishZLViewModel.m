//
//  PublishZLViewModel.m
//  UEHTML
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "PublishZLViewModel.h"
#import "ATQPublishViewController.h"
@implementation PublishZLViewModel


+ (PublishZLViewModel *)shareInstance{
    static PublishZLViewModel * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


#pragma mark ===================开始网络请求==================
/** 开始网络请求 */
- (void)startAFNetWorkingGetListWithType:(PublishNetWorking_enum)type withPage:(NSInteger )page{
    NSString * urlString = nil;
    NSDictionary *param = @{};
    NSString * pageString = [NSString stringWithFormat:@"%ld",page];
    switch (type) {
        case FUWUFANG_TUIJIAN:{
            urlString = [NSString stringWithFormat:@"%@/api/job/recommend/demand",Common_URL_ZL];
        }
            break;
        case FUWUFANG_MYLIST:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/service",Common_URL_ZL];
            param = @{
                      @"model":@"1",
                      @"page_index":pageString
                      };
        }
            break;
        case XUQIUFANG_MYLIST:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/demand",Common_URL_ZL];
            param = @{
                      @"model":@"1",
                      @"page_index":pageString
                      };
        }
            break;
        case XUQIUFANG_TUIJIAN:{
            urlString = [NSString stringWithFormat:@"%@/api/job/recommend/work",Common_URL_ZL];
        }
            break;
        case FUWUFANG_DOING:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/service",Common_URL_ZL];
            param = @{
                      @"model":@"2",
                      @"page_index":pageString
                      };
        }
            break;
        case FUWUFANG_FINISHED:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/service",Common_URL_ZL];
            param = @{
                      @"model":@"3",
                      @"page_index":pageString
                      };
        }
            break;
        case XUQIUFANG_DOING:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/demand",Common_URL_ZL];
            param = @{
                      @"model":@"2",
                      @"page_index":pageString
                      };
        }
            break;
        case XUQIUFANG_FINISHED:{
            urlString = [NSString stringWithFormat:@"%@/api/job/order_list/demand",Common_URL_ZL];
            param = @{
                      @"model":@"3",
                      @"page_index":pageString
                      };
        }
            break;
        default:
            break;
    }
    NSLog(@"兼职网络请求链接：%@",urlString);
    [[ZLSecondAFNetworking sharedInstance] postWithUSER_INFO_URLString:urlString parameters:param success:^(id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"兼职列表请求：%@",dic);
        if (![dic[@"status"] isEqualToString:@"1"]) {
            return;
        }
        NSArray * dataArray = dic[@"data"];
        if (page == 1) {
            [self.currentListArray removeAllObjects];
        }
        switch (type) {
            case FUWUFANG_TUIJIAN:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[FuWuFangTuiJianCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(XUQIUFANG_TUIJIAN, self.currentListArray);
            }
                break;
            case FUWUFANG_MYLIST:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[FuWuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(FUWUFANG_MYLIST, self.currentListArray);
            }
                break;
            case XUQIUFANG_MYLIST:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[XuQiuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(XUQIUFANG_MYLIST, self.currentListArray);
            }
                break;
            case XUQIUFANG_TUIJIAN:{
               NSArray * arr = [MTLJSONAdapter modelsOfClass:[XuQiuFangTuiJianCellModel class] fromJSONArray:dataArray error:nil];
               [self.currentListArray addObjectsFromArray:arr];
               self.getblock(XUQIUFANG_TUIJIAN, self.currentListArray);
            }
                break;
            case FUWUFANG_DOING:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[FuWuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(FUWUFANG_DOING, self.currentListArray);
            }
                break;
            case FUWUFANG_FINISHED:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[FuWuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(FUWUFANG_FINISHED, self.currentListArray);
            }
                break;
            case XUQIUFANG_DOING:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[XuQiuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(XUQIUFANG_DOING, self.currentListArray);
            }
                break;
            case XUQIUFANG_FINISHED:{
                NSArray * arr = [MTLJSONAdapter modelsOfClass:[XuQiuFangMyListCellModel class] fromJSONArray:dataArray error:nil];
                [self.currentListArray addObjectsFromArray:arr];
                self.getblock(XUQIUFANG_FINISHED, self.currentListArray);
            }
                break;
            default:
                break;
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"兼职列表请求错误:%@",error);
    }];
    
}
#pragma mark ===================网络请求结束==================
#pragma mark ===================懒加载==================
- (NSMutableArray *)fuWuMyListArray{
    if (!_fuWuMyListArray) {
        _fuWuMyListArray = [NSMutableArray new];
    }
    return _fuWuMyListArray;
}
- (NSMutableArray *)fuWuTuiJIanArray{
    if (!_fuWuTuiJIanArray) {
        _fuWuTuiJIanArray = [NSMutableArray new];
    }
    return _fuWuTuiJIanArray;
}
- (NSMutableArray *)fuWuFinishedArray{
    if (!_fuWuFinishedArray) {
        _fuWuFinishedArray = [NSMutableArray new];
    }
    return _fuWuFinishedArray;
}
- (NSMutableArray *)fuWuDoingListArray{
    if (!_fuWuDoingListArray) {
        _fuWuDoingListArray = [NSMutableArray new];
    }
    return _fuWuDoingListArray;
}
- (NSMutableArray *)xuQiuMyListArray{
    
    if (!_xuQiuMyListArray) {
        _xuQiuMyListArray = [NSMutableArray new];
    }
    return _xuQiuMyListArray;
}
- (NSMutableArray *)xuQiuTuiJianArray{
    if (!_xuQiuTuiJianArray) {
        _xuQiuTuiJianArray = [NSMutableArray new];
    }
    return _xuQiuTuiJianArray;
}
- (NSMutableArray *)xuQiuDoingListArray{
    if (!_xuQiuDoingListArray) {
        _xuQiuDoingListArray = [NSMutableArray new];
    }
    return _xuQiuDoingListArray;
}

- (NSMutableArray *)XuQiuFinishedArray{
    if (!_XuQiuFinishedArray) {
        _XuQiuFinishedArray = [NSMutableArray new];
    }
    return _XuQiuFinishedArray;
}
- (NSMutableArray *)currentListArray{
    if (!_currentListArray) {
        _currentListArray = [NSMutableArray new];
    }
    return _currentListArray;
}
#pragma mark ===================懒加载结束==================
#pragma mark ===================其他设置==================
- (void)getPublishModelArrayBlockAction:(GetPublishModelArrayBlock)block{
    self.getblock = block;
}

@end
