//
//  ATQBuyjbFirTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/10/1.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void(^ChongzhiVipBlock)();
@interface ATQBuyjbFirTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jinbiLab;
@property (weak, nonatomic) IBOutlet UIButton *chongzhiVipBtn;
@property (weak, nonatomic) IBOutlet UILabel *guizeLab;
@property(copy,nonatomic)ChongzhiVipBlock chongzhiVipblock;
@end
