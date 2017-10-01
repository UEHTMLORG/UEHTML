//
//  ATQAccountFirTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/30.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^JinbiBlock)();
typedef void (^LiwuBlock)();
typedef void (^VIPBlock)();
@interface ATQAccountFirTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jinbiLab;
@property (weak, nonatomic) IBOutlet UILabel *liwuLab;
@property(copy,nonatomic)JinbiBlock jinbiblock;
@property(copy,nonatomic)LiwuBlock liwublock;
@property(copy,nonatomic)VIPBlock vipblock;
@end
