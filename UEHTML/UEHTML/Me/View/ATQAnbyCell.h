//
//  ATQAnbyCell.h
//  UEHTML
//
//  Created by LHKH on 2017/11/20.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CancelBlock)();
typedef void (^SureBlock)();
@interface ATQAnbyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *abyImg;
@property (weak, nonatomic) IBOutlet UILabel *abyLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *txLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *phoneImg;
@property (weak, nonatomic) IBOutlet UIImageView *idcardImg;
@property (weak, nonatomic) IBOutlet UIImageView *vedioImg;
@property (weak, nonatomic) IBOutlet UIImageView *carImg;
@property (weak, nonatomic) IBOutlet UIImageView *sfImg;
@property (weak, nonatomic) IBOutlet UILabel *addrLab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *disLab;
@property (weak, nonatomic) IBOutlet UILabel *outDataLab;
@property (copy,nonatomic)CancelBlock cancelblock;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *idcardH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vedioH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sfH;
@end
