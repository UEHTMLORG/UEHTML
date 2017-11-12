//
//  DetailXuQiuViewModel.h
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailXuQiuViewController;
#import "DetailXuQiuModel.h"

@interface DetailXuQiuViewModel : NSObject

@property (nonatomic, strong) DetailXuQiuModel *currentModel;
@property (nonatomic, strong) DetailXuQiuViewController *currentController;
/** 单例创建对象 */
+ (DetailXuQiuViewModel *)shareInstance;
/** 请求网络数据 */
- (void)startAFNetWorkingGetListWithJobID:(NSString *)jobId withController:(DetailXuQiuViewController *)controller resultSuccessBlock:(void (^)(BOOL success,DetailXuQiuModel * model))successBlock withFailBlock:(void (^)(NSError * error)) failBlock;

@end
