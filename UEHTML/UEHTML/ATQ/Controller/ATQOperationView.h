//
//  ATQOperationView.h
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQOperationView : UIView
@property (nonatomic,assign)BOOL isShowing;
@property (nonatomic,copy)void (^commentBtnClicked)();
@property (nonatomic,copy)void (^likeBtnClicked)();
@property (nonatomic,copy)NSString *praiseString;
@end
