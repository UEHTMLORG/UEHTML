//
//  ATQPublishAddrViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/11/19.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol ATQPublishAddrViewControllerDelegate <NSObject>
- (void)ATQPublishAddrViewControllerDelegate:(NSString*)addrStr;
@end
@interface ATQPublishAddrViewController : ATQBaseViewController
@property (strong,nonatomic)NSMutableArray *addrArr;
@property (weak, nonatomic)id<ATQPublishAddrViewControllerDelegate>delegate;
@end
