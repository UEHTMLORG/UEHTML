//
//  ATQAccountThiTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TixianBlock)();
@interface ATQAccountThiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *zongLab;
@property (weak, nonatomic) IBOutlet UILabel *jinriLab;
@property (weak, nonatomic) IBOutlet UILabel *dongjieLab;
@property (weak, nonatomic) IBOutlet UILabel *tixianLab;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@property (copy, nonatomic)TixianBlock tixianblock;
@end
