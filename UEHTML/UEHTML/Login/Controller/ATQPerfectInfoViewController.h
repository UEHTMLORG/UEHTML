//
//  ATQPerfectInfoViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/20.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"

@interface ATQPerfectInfoViewController : ATQBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UIView *nickView;
@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIView *ageView;
@property (weak, nonatomic) IBOutlet UITextField *nickText;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;


@end
