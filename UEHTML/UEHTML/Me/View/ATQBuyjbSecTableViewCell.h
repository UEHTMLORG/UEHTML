//
//  ATQBuyjbSecTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BuyBlock)();
@interface ATQBuyjbSecTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;
@property (weak, nonatomic) IBOutlet UILabel *jinbiLab;
@property (weak, nonatomic) IBOutlet UILabel *zengsongLab;
@property (weak, nonatomic) IBOutlet UIButton *jiageBtn;
@property (copy,nonatomic)BuyBlock buyblock;
@end
