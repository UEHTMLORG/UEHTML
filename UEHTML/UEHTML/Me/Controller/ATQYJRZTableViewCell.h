//
//  ATQYJRZTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^lvRenzhengBlock)();
@interface ATQYJRZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lvImg;
@property (weak, nonatomic) IBOutlet UILabel *lvLab;
@property (weak, nonatomic) IBOutlet UILabel *lvMoney;
@property (weak, nonatomic) IBOutlet UIButton *lvBtn;
@property(copy,nonatomic)lvRenzhengBlock renzhengblock;
@end
