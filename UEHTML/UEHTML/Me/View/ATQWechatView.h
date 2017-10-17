//
//  ATQWechatView.h
//  UEHTML
//
//  Created by LHKH on 2017/9/26.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^searchBlock)();
typedef void (^saveBlock)();
@interface ATQWechatView : UIView
@property (weak, nonatomic) IBOutlet UIView *firView;
@property (weak, nonatomic) IBOutlet UITextField *wechatText;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UILabel *shouyiLab;
@property (weak, nonatomic) IBOutlet UIButton *searchWechatBtn;

@property (copy, nonatomic)searchBlock searchblock;
@property (copy, nonatomic)saveBlock saveblock;
+ (ATQWechatView *)wechatView;
@end
