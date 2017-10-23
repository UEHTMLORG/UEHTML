//
//  ATQSecendTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/24.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SetSwitchBlock)(BOOL isSet);
typedef void (^SetTimeBlock)(NSString *timeStr);
@interface ATQSecendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *setSwitch;
@property (weak, nonatomic) IBOutlet UITextField *timeText;

@property(nonatomic,copy)SetSwitchBlock setswitchblock;
@property(nonatomic,copy)SetTimeBlock settimeblock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *setviewH;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;

@end
