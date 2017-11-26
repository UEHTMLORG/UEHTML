//
//  MessageControllerViewModel.h
//  UEHTML
//
//  Created by apple on 2017/11/26.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgLastZaiXianModel.h"
@interface MessageControllerViewModel : NSObject
+ (MessageControllerViewModel *)shareInstance;

/** 最近在线 */
- (void)startZuiJinOnlineNetWork:(void (^)(BOOL success,NSArray<MsgLastZaiXianModel *> *modelArr))success failBlock:(void (^)(BOOL result))failblock;

@end
