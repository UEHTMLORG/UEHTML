//
//  ATQMyFriendsViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol ATQMyFriendsViewControllerDelegate <NSObject>
- (void)ATQMyFriendsViewControllerDelegate:(NSString*)addrStr;
@end
@interface ATQMyFriendsViewController : ATQBaseViewController
@property(copy,nonatomic)NSString *selecttypeStr;
@property(weak,nonatomic)id<ATQMyFriendsViewControllerDelegate>delegate;
@end
