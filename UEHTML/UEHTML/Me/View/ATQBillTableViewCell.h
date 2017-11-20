//
//  ATQBillTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQBillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *billImg;
@property (weak, nonatomic) IBOutlet UILabel *billSRLab;
@property (weak, nonatomic) IBOutlet UILabel *billJYLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;

@end
