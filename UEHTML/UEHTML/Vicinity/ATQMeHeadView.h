//
//  ATQMeHeadView.h
//  UEHTML
//
//  Created by LHKH on 2017/9/23.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^setupBlock)();
@interface ATQMeHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *VIPView1;
@property (weak, nonatomic) IBOutlet UIView *VIPView2;
@property (weak, nonatomic) IBOutlet UIView *cView;
@property (copy, nonatomic)setupBlock setupblock;
+ (ATQMeHeadView *)meHeadView;
@end
