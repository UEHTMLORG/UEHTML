//
//  TiGongTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianZhiListCellModel.h"
#import "PublishZLViewModel.h"
@interface TiGongTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImage;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;
@property (strong, nonatomic) IBOutlet UIImageView *carImage;
@property (strong, nonatomic) IBOutlet UILabel *mioneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;


- (void)bindWithMyModel:(FuWuFangMyListCellModel *)model;


@end


@interface FuWuFangTuiJianCell: UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sexImage;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;
@property (strong, nonatomic) IBOutlet UIImageView *carImage;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;
@property (strong, nonatomic) IBOutlet UILabel *chengLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;



@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;

- (void)bindWithTuiJianModel:(FuWuFangTuiJianCellModel *)model;

@end
