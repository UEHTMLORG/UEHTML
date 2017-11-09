//
//  JianZhiTableViewCell.h
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianZhiListCellModel.h"
#import "PublishZLViewModel.h"

@interface JianZhiTableViewCell : UITableViewCell

@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *status_titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobModelLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;

- (void)bindMyModel:(XuQiuFangMyListCellModel *)model;

@end

@interface XuQiuFangTuiJianCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;



@property (nonatomic, assign) PublishNetWorking_enum curPublishNetworkType;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *chengNumLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;
@property (strong, nonatomic) IBOutlet UIButton *voiceButton;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;


- (void)bindTuiJianModel:(XuQiuFangTuiJianCellModel *)model;
    

@end

