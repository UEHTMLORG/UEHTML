//
//  FaBuJianZhiTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBuJianZhiTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *fuWuJieShaoTextField;
@property (strong, nonatomic) IBOutlet UITextField *fuWuJiaGeTextField;
@property (strong, nonatomic) IBOutlet UITextField *fuWuShiChangTextField;
@property (strong, nonatomic) IBOutlet UITextView *fuWuBeiZhuTextField;
@property (strong, nonatomic) IBOutlet UIButton *luYinButton;
@property (strong, nonatomic) IBOutlet UIImageView *luYinImageView;
@property (strong, nonatomic) IBOutlet UIButton *tiJiaoShenHeButton;
@property (strong, nonatomic) IBOutlet UIButton *shiLiButton;



@end
