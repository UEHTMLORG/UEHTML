//
//  ATQPaixuView.h
//  UEHTML
//
//  Created by LHKH on 2017/11/13.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ATQPaixuViewDelegate <NSObject>
- (void)paixuViewClick:(NSInteger)senderTag;
@end
@interface ATQPaixuView : UIView
@property (weak,nonatomic)id <ATQPaixuViewDelegate>delegate;
+ (ATQPaixuView *)meHeadView;
@end
