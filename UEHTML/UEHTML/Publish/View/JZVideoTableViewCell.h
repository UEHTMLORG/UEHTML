//
//  JZVideoTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZVideoCellModel.h"

@interface JZVideoTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shiJianLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *shiChangLabel;


- (void)bindWithModel:(JZVideoCellModel *)model;

@end
