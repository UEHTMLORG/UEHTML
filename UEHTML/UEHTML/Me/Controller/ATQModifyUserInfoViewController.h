//
//  ATQModifyUserInfoViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol modifyPassValueDelegate <NSObject>
-(void)passmodifyValue:(NSString*)SusStr type:(NSString*)type;
@end
@interface ATQModifyUserInfoViewController : ATQBaseViewController
@property(nonatomic,copy)NSString *passStr;
@property(nonatomic,copy)NSString *natitle;
@property(weak,nonatomic)id<modifyPassValueDelegate>delegate;
@end
