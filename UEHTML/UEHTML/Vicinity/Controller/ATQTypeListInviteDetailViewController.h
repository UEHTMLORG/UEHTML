//
//  ATQTypeListInviteDetailViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/10/10.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "ATQPlaceholderTextView.h"
@interface ATQTypeListInviteDetailViewController : ATQBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *texingLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *fuwuTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *fuwuJiageLab;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet ATQPlaceholderTextView *beizhuText;
@property (weak, nonatomic) IBOutlet UILabel *zongJineLab;
@property (weak, nonatomic) IBOutlet UILabel *taRZLab;
@property (weak, nonatomic) IBOutlet UILabel *meRZLab;
@property (weak, nonatomic) IBOutlet UIButton *yajinRZBtn;
@property (nonatomic,copy) NSString *jobID;
@end
