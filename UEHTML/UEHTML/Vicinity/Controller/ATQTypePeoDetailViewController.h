//
//  ATQTypePeoDetailViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"
#import "ATQPlaceholderTextView.h"
#import "CPStepper.h"
@interface ATQTypePeoDetailViewController : ATQBaseViewController
@property (weak, nonatomic) IBOutlet ATQPlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *tagLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *chengLab;
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;
@property (weak, nonatomic) IBOutlet UILabel *yuyueTimeLab;
@property (weak, nonatomic) IBOutlet CPStepper *textField;
@property (weak, nonatomic) IBOutlet UILabel *shijineLab;
@property (weak, nonatomic) IBOutlet UITextField *addrText;
@property (weak, nonatomic) IBOutlet UILabel *baojiaLab;
@property (weak, nonatomic) IBOutlet ATQPlaceholderTextView *xuqiuText;
@property (weak, nonatomic) IBOutlet UILabel *zongjineLab;
@property (weak, nonatomic) IBOutlet UILabel *tarenzhengLab;
@property (weak, nonatomic) IBOutlet UILabel *merenzhengLab;
@property (weak, nonatomic) IBOutlet UIButton *yajinBtn;

@property (copy, nonatomic)NSString *jobID;

@end
