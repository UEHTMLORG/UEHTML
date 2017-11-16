//
//  DetailSubPublishViewModel.h
//  UEHTML
//
//  Created by apple on 2017/11/12.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailSubPublishModel.h"

@interface DetailSubPublishViewModel : NSObject

@property (nonatomic, strong) DetailSubPublishModel *currentModel;
/** 单例创建对象 */
+ (DetailSubPublishViewModel *)shareInstance;
/** 请求网络数据 */
- (void)startAFNetWorkingGetListWithJobID:(NSString *)jobId resultSuccessBlock:(void (^)(BOOL success,DetailSubPublishModel * model))successBlock withFailBlock:(void (^)(NSError * error)) failBlock;


@end
