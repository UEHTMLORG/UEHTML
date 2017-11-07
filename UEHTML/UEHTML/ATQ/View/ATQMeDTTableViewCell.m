//
//  ATQMeDTTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/11/7.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQMeDTTableViewCell.h"
#import "ATQDTImageView.h"
#import "ATQDTContentView.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "ATQDTModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+ZJ.h"
@interface ATQMeDTTableViewCell ()<ATQDTImageViewDelegate>
@property (nonatomic,strong)UILabel *timeLabel;//发布的时间
@property (nonatomic,strong)UILabel *ytimeLabel;//发布年的时间
@property (nonatomic,strong)UILabel *addrLabel;//所属地方
@property (nonatomic,strong)UILabel *msgLabel;//动态内容
@property (nonatomic,strong)ATQDTImageView *DTimageView;//动态的图片
@property (nonatomic,strong)ATQDTContentView *DTContentView;//动态的图片
@property (nonatomic,strong)UILabel *chakanLabel;//多少人查看
@property (nonatomic,strong)UILabel *pinglunLabel;//多少人评论
@property (nonatomic,strong)UILabel *huaLabel;//多少人送花
@property (nonatomic,strong) UIButton *moreBtn;//展开按钮
@property (nonatomic,strong) NSIndexPath *indexPath;//展开按钮
@property (strong,nonatomic)ATQDTModel *model;
@end

@implementation ATQMeDTTableViewCell

#pragma mark - Life Cycle


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self BuildViews];
    }
    return self;
}

-(void)BuildViews{
    //发布的时间
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectZero];
    timeLab.text = @"137月";
    timeLab.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:timeLab];
    self.timeLabel = timeLab;
    
    //发布年的时间
    UILabel *ytimeLab = [[UILabel alloc]initWithFrame:CGRectZero];
    ytimeLab.text = @"2016年";
    ytimeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:ytimeLab];
    self.ytimeLabel = ytimeLab;
    
    //所属地方
    UILabel *addrLab = [[UILabel alloc] initWithFrame:CGRectZero];
    addrLab.text = @"上海";
    addrLab.font = [UIFont systemFontOfSize:14];
    addrLab.textColor = [UIColor colorWithHexString:UIColorStr];
    [self.contentView addSubview:addrLab];
    self.addrLabel = addrLab;
    
    //动态内容
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.text = @"陈一发唱的童话镇还是很不错的";
    msgLabel.font = [UIFont systemFontOfSize:14];
    msgLabel.textColor = [UIColor colorWithHexString:UIDTTextColorStr];
    msgLabel.numberOfLines = 0;
    [self.contentView addSubview:msgLabel];
    self.msgLabel = msgLabel;
    
    //展开按钮
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [moreBtn setTitleColor:[UIColor colorWithHexString:UIDeepTextColorStr] forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor colorWithHexString:UIDeepTextColorStr] forState:UIControlStateSelected];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    moreBtn.selected = NO;
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    
    //动态图片
    ATQDTImageView *DTImageView = [[ATQDTImageView alloc] init];
    DTImageView.delegate = self;
    [self.contentView addSubview:DTImageView];
    self.DTimageView = DTImageView;
    
    //多少人查看view
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:bottomView];
    UILabel *chakanLab = [[UILabel alloc] initWithFrame:CGRectZero];
    chakanLab.text = @"118人查看";
    chakanLab.textColor = [UIColor colorWithHexString:UIDeepToneTextColorStr];
    chakanLab.font = [UIFont systemFontOfSize:12];
    self.chakanLabel = chakanLab;
    [bottomView addSubview:chakanLab];
    
    //删除按钮
    UIButton *delBtn = [[UIButton alloc] init];
    [delBtn setTitle:@"删除" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor colorWithHexString:UIDeepTextColorStr] forState:UIControlStateNormal];
    delBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    delBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [delBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:delBtn];
    
    UILabel *pinglunLab = [[UILabel alloc] initWithFrame:CGRectZero];
    pinglunLab.text = @"118";
    pinglunLab.textColor = [UIColor colorWithHexString:UIDeepToneTextColorStr];
    pinglunLab.font = [UIFont systemFontOfSize:12];
    self.pinglunLabel = pinglunLab;
    [bottomView addSubview:pinglunLab];
    UILabel *huaLab = [[UILabel alloc] initWithFrame:CGRectZero];
    huaLab.text = @"118";
    huaLab.textColor = [UIColor colorWithHexString:UIDeepToneTextColorStr];
    huaLab.font = [UIFont systemFontOfSize:12];
    self.huaLabel = huaLab;
    [bottomView addSubview:huaLab];
    UIImageView *pinglunImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    pinglunImg.image = [UIImage imageNamed:@"aotuquan-liuyan"];
    [bottomView addSubview:pinglunImg];
    UIImageView *huaImg = [[UIImageView alloc]initWithFrame:CGRectZero];
    huaImg.image = [UIImage imageNamed:@"aotuquan-hua"];
    [bottomView addSubview:huaImg];
    
    UIButton *huaBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [huaBtn addTarget:self action:@selector(huaClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:huaBtn];
    UIButton *pinglunBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [pinglunBtn addTarget:self action:@selector(pinglunClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:pinglunBtn];
    
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectZero];
    spaceView.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
    [self.contentView addSubview:spaceView];
    
    //动态评论
    ATQDTContentView *DTContentView = [[ATQDTContentView alloc] init];
    DTContentView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:DTContentView];
    self.DTContentView = DTContentView;
    
    //时间
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.equalTo(msgLabel.mas_left).with.offset(-10);
    }];
    
    //年时间
    [ytimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeLab.mas_bottom).with.offset(10);
        make.left.equalTo(timeLab.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.equalTo(msgLabel.mas_left).with.offset(-10);
    }];
    
    //位置
    [addrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ytimeLab.mas_left);
        make.size.mas_equalTo(CGSizeMake(50,20));
        make.top.equalTo(ytimeLab.mas_bottom).offset(5);
    }];
  
    //动态信息
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.left.mas_equalTo(timeLab.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    msgLabel.preferredMaxLayoutWidth = ScreenWidth-80;
    
    //更多按钮
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(msgLabel);
    }];
    
    //动态图片
    [DTImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(msgLabel);
        make.right.equalTo(msgLabel.mas_right);
        
    }];
    
    //下面查看人数   评论  花
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.left.right.mas_equalTo(self.msgLabel);
        make.top.mas_equalTo(DTImageView.mas_bottom).offset(10);
    }];
    
    //动态评论
    [DTContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).offset(10);
        make.left.mas_equalTo(msgLabel);
        make.right.equalTo(msgLabel.mas_right);
    }];
    
    [chakanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.left.top.bottom.mas_equalTo(bottomView);
    }];
    
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.left.equalTo(chakanLab.mas_right).offset(10);
        make.top.bottom.equalTo(bottomView);
    }];
    
    [huaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.width.offset(35);
        make.right.top.bottom.mas_equalTo(bottomView);
        
    }];
    [huaImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(20);
        make.top.bottom.mas_equalTo(bottomView);
        make.right.mas_equalTo(huaLab.mas_left).offset(-5);
    }];
    
    [pinglunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.width.offset(35);
        make.top.bottom.mas_equalTo(bottomView);
        make.right.mas_equalTo(huaImg.mas_left);
        
    }];
    [pinglunImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(20);
        make.top.bottom.mas_equalTo(bottomView);
        make.right.mas_equalTo(pinglunLab.mas_left).offset(-5);
    }];
    
    [huaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(huaImg.mas_left);
        make.right.mas_equalTo(huaLab.mas_right);
    }];
    [pinglunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(pinglunImg.mas_left);
        make.right.mas_equalTo(pinglunLab.mas_right);
    }];
    
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
}

- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath
{
    _model = model;
    self.indexPath = indexPath;
    self.msgLabel.text = model.desc;
    self.pinglunLabel.text = model.message_num;
    self.chakanLabel.text = [NSString stringWithFormat:@"%@人查看",model.read_num];
    self.huaLabel.text = model.flower_num;
    self.addrLabel.text = model.city;
    NSString *str = [NSString stringWithFormat:@"%@%@",model.day,model.month];
    if (str.length>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, (str.length-2))];
        self.timeLabel.attributedText = attrStr;
    }
    self.ytimeLabel.text = model.year;
    if (model.year == nil || [model.year isEqualToString:@""]) {
        [self.ytimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).with.offset(10);
            make.left.equalTo(self.timeLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(50, 0));
            make.right.equalTo(self.msgLabel.mas_left).with.offset(-10);
        }];
    }else{
        
        [self.ytimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).with.offset(10);
            make.left.equalTo(self.timeLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(50, 20));
            make.right.equalTo(self.msgLabel.mas_left).with.offset(-10);
        }];
    }
    
    float msgHeight = [NSString stringHeightWithString:model.desc size:14 maxWidth: ScreenWidth-80];
    if(msgHeight <=60)
    {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msgLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.msgLabel);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    else
    {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msgLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.msgLabel);
        }];
    }
    if(model.isExpand)
    {
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(5);
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(msgHeight);
        }];
    }
    else
    {
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(5);
            make.left.mas_equalTo(self.timeLabel.mas_right).offset(10);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(60);
        }];
    }
    self.moreBtn.selected = model.isExpand;
    
    CGSize imageContainViewSize;
    if(model.pictures.count==0)
    {
        imageContainViewSize = CGSizeMake(0, 0);
    }
    else if (model.pictures.count>0 && model.pictures.count<4)
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80, (ScreenWidth-80-10)/3);
    }
    else
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80,(2*(ScreenWidth-90)/3)+5);
    }
    [self.DTimageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreBtn.mas_bottom).with.offset(5);
        make.left.mas_equalTo(self.moreBtn);
        make.size.mas_equalTo(imageContainViewSize);
    }];
    
    self.DTimageView.model = model;
    [self.DTContentView configCellWithModel:model indexPath:indexPath];
    
}

-(void)moreAction:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(didClickMeMoreBtn:indexPath:)])
    {
        [_delegate didClickMeMoreBtn:sender indexPath:self.indexPath];
    }
}

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView{
    if([_delegate respondsToSelector:@selector(didClickMeImageViewWithCurrentCell:imageViewArray:imageSuperView:indexPath:)])
    {
        [_delegate didClickMeImageViewWithCurrentCell:imageView imageViewArray:array imageSuperView:superView indexPath:self.indexPath];
    }
}

-(void)delAction:(UIButton*)sender{
    NSLog(@"del---");
    if([self.delegate respondsToSelector:@selector(didClickMeDelWithIndexPath:)])
    {
        [self.delegate didClickMeDelWithIndexPath:self.indexPath];
    }
}

-(void)huaClick{
    NSLog(@"hua---");
    if([self.delegate respondsToSelector:@selector(didClickMeHuaWithIndexPath:)])
    {
        [self.delegate didClickMeHuaWithIndexPath:self.indexPath];
    }
}
-(void)pinglunClick{
    NSLog(@"pinglun---");
    if([self.delegate respondsToSelector:@selector(didClickMeCommentWithIndexPath:)])
    {
        [self.delegate didClickMeCommentWithIndexPath:self.indexPath];
    }
}

@end

