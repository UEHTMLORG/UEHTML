//
//  ATQRegisterViewController.h
//  UEHTML
//
//  Created by LHKH on 2017/9/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQBaseViewController.h"

@interface ATQRegisterViewController : ATQBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *registerTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TextTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomH;

@end
