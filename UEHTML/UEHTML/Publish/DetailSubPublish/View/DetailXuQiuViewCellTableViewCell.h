//
//  DetailXuQiuViewCellTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/11/9.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailXuQiuViewCellTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;
@property (strong, nonatomic) IBOutlet UIImageView *carImage;
@property (strong, nonatomic) IBOutlet UILabel *chengLabel;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;

@end

@interface DetailXuQiuViewJobNameCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *shiChangLabel;



@end

@interface DetailXuQiuViewJobTimeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *letImage;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;



@end
