//
//  ZhaoRenFuWuViewModel.h
//  UEHTML
//
//  Created by apple on 2017/11/23.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhaoRenFuWuViewModel : NSObject

+ (ZhaoRenFuWuViewModel *)shareInstance;

/** 提交审核 网络请求 */
- (void)startTiJiaoAFWorkingWithClass_id:(NSString *)class_id withIntroduce:(NSString *)introduce withPrice:(NSString *)price withTime:(NSString *)time withVoice:(NSString *)voice withRemark:(NSString *)remark withBackBlock:(void (^)(BOOL success))backBlock;

@end
