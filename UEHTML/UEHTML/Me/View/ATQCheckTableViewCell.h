//
//  ATQCheckTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQCheckTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leibieImg;
@property (weak, nonatomic) IBOutlet UILabel *leibieName;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@end
