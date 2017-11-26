//
//  DetailSubPublishCell.h
//  UEHTML
//
//  Created by apple on 2017/11/6.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiWuPublishCollectionViewCell.h"
#import "SkillPublishCollectionViewCell.h"
#import "DetailSubPublishModel.h"

@interface DetailSubPublishCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *homeButton;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (strong, nonatomic) IBOutlet UIButton *shouCangButton;
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *juliLabel;
@property (strong, nonatomic) IBOutlet UIButton *guanZhuButton;
@property (strong, nonatomic) IBOutlet UIButton *leftBackButton;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end

@interface DetailSubPublishSecondCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *weiXinLabel;
@property (strong, nonatomic) IBOutlet UIButton *chaKanWeiXinButton;
@property (strong, nonatomic) IBOutlet UIImageView *diWangImage;
@property (strong, nonatomic) IBOutlet UIImageView *vipImage;
@property (strong, nonatomic) IBOutlet UILabel *chengLabel;
@property (strong, nonatomic) IBOutlet UIButton *voiceButton;
@property (strong, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *fuWuTypeLabel;


@end

@interface DetailSubPublishThirdCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;



@end

@interface DetailSubPublishFourCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *liWuArray;

- (void)bindDataWithModel:(DetailSubPublishModel *)model;

@end

@interface DetailSubPublishFiveCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *skillArray;

- (void)bindDataWithModel:(DetailSubPublishModel *)model;


@end

@interface DetailSubPublishSixCell : UITableViewCell


@end
@interface DetailSubPublishSevenCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end


