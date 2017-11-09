//
//  ATQModifyZhanghaoViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
@protocol modifyPasszhanghuDelegate <NSObject>
-(void)passzhanghuValue:(NSString*)SusStr;
@end
@interface ATQModifyZhanghaoViewController : ATQBaseViewController
@property(nonatomic,copy)NSString *passStr;
@property(nonatomic,copy)NSString *natitle;
@property(weak,nonatomic)id<modifyPasszhanghuDelegate>delegate;
@end
