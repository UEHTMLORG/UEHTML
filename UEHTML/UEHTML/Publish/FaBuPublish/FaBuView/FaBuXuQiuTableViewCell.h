//
//  FaBuXuQiuTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBuXuQiuTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *fuWuDiZhiTextField;
@property (strong, nonatomic) IBOutlet UITextField *jinEField;
@property (strong, nonatomic) IBOutlet UITextField *shiChangField;
@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UITextView *shuoMingField;
@property (strong, nonatomic) IBOutlet UIButton *age01Button;
@property (strong, nonatomic) IBOutlet UIButton *age02Button;
@property (strong, nonatomic) IBOutlet UIButton *age03Button;
@property (strong, nonatomic) IBOutlet UIButton *sex01Button;
@property (strong, nonatomic) IBOutlet UIButton *sex02button;
@property (strong, nonatomic) IBOutlet UIButton *sexNOButton;
@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (strong, nonatomic) IBOutlet MLLinkLabel *yaJinLabel;
@property (strong, nonatomic) IBOutlet UIButton *tijiaoButton;


@end

@interface FaBuXuQiuLvYouCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *mudiButton;
@property (strong, nonatomic) IBOutlet UIButton *chuFaTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *yujiTimeButton;
@property (strong, nonatomic) IBOutlet UIButton *chuXingButton;
@property (strong, nonatomic) IBOutlet UIButton *priceButton;
@property (strong, nonatomic) IBOutlet UITextView *shuoMingTextField;
@property (strong, nonatomic) IBOutlet UIButton *age01button;
@property (strong, nonatomic) IBOutlet UIButton *age02Button;
@property (strong, nonatomic) IBOutlet UIButton *age03Button;
@property (strong, nonatomic) IBOutlet UIButton *sexNanButton;
@property (strong, nonatomic) IBOutlet UIButton *sexNvButton;
@property (strong, nonatomic) IBOutlet UIButton *sexNOButton;
@property (strong, nonatomic) IBOutlet UILabel *allPriceLabel;
@property (strong, nonatomic) IBOutlet MLLinkLabel *yaJinLabel;
@property (strong, nonatomic) IBOutlet UIButton *tiJiaoButton;

@end
