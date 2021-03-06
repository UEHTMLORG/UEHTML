//
//  ATQJZTypeListTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AudioBlock)();
@interface ATQJZTypeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *chengLab;
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *texingLab;
@property (weak, nonatomic) IBOutlet UILabel *yuyinLab;
@property (weak, nonatomic) IBOutlet UIImageView *rzImg;
@property (weak, nonatomic) IBOutlet UIImageView *vipImg;
@property (weak, nonatomic) IBOutlet UIImageView *shipingImg;
@property (copy, nonatomic) AudioBlock audioblock;
@end
