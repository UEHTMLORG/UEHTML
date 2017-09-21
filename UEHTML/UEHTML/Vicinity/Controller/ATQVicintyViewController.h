//
//  ATQVicintyViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
typedef NS_ENUM(NSUInteger, selectType) {
    selectNearbyType = 0, // 附近
    selectRecommendType = 1, // 推荐
    selectVideoChatType = 2, // 视频聊天
};
@interface ATQVicintyViewController : ATQBaseViewController

@end
