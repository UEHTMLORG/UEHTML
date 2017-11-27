//
//  ZLRongYunManager.h
//  UEHTML
//
//  Created by apple on 2017/11/14.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLRongYunManager : NSObject<RCIMUserInfoDataSource>


+ (ZLRongYunManager *)shareInstance;
- (void)rongYunLogin;


@end
