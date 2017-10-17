//
//  ATQSZLoginOutTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^loginOutBlock)();
@interface ATQSZLoginOutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;
@property (copy, nonatomic)loginOutBlock loginoutblock;
@end
