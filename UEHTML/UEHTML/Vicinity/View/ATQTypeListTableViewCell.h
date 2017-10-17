//
//  ATQTypeListTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ATQTypeListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg1;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg2;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg3;
@property (weak, nonatomic) IBOutlet UILabel *chengLab;
@property (weak, nonatomic) IBOutlet UILabel *distLab;
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *instrLab;

@end
