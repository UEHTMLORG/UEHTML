//
//  ATQViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
typedef NS_ENUM(NSUInteger, ATQselectType) {
    ATQselectTCType = 0, // 同城
    ATQselectHYType = 1, // 好友
    ATQselectMEType = 2, // 我的
};
@interface ATQViewController : ATQBaseViewController

@end
