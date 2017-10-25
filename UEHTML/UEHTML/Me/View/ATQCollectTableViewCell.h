//
//  ATQCollectTableViewCell.h
//  UEHTML
//
//  Created by LHKH on 2017/9/25.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YuetaBlock)();
@interface ATQCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *bqLab;
@property (weak, nonatomic) IBOutlet UIButton *disBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bqImg;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property(copy,nonatomic)YuetaBlock yuetablock;
@end
