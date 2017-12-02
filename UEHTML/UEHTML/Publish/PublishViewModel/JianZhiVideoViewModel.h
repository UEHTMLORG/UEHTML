//
//  JianZhiVideoViewModel.h
//  UEHTML
//
//  Created by apple on 2017/12/1.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZVideoCellModel.h"

@interface JianZhiVideoViewModel : NSObject

+ (JianZhiVideoViewModel *)shareInstance;

/** 我发起的视频和我接受的视频 type 1 我发起的视频 2 我接收的视频*/
- (void)startAFNetworkingJianZhiVideoWithType:(int )type withSuccessBlock:(void (^)(BOOL success,NSArray <JZVideoCellModel *>* array))success withFailBlock:(void (^)(BOOL fail)) failure;


@end
