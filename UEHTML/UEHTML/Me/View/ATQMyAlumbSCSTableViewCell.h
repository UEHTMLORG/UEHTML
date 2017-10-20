//
//  ATQMyAlumbSCSTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectSwicthBlock)(BOOL isSel);
@interface ATQMyAlumbSCSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *secretSwicth;
@property (copy,nonatomic)SelectSwicthBlock selectSwicthblock;
@end
