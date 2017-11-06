//
//  ATQDTTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/18.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQDTTableViewCell.h"
#import "ATQDTImageView.h"
#import "ATQDTContentView.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "ATQDTModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+ZJ.h"

@interface ATQDTTableViewCell()<ATQDTImageViewDelegate>
@property (nonatomic,strong)UIImageView *headImageView;//头像
@property (nonatomic,strong)UILabel *addrLabel;//所属地方
@property (nonatomic,strong)UILabel *nameLabel;//昵称
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
@implementation ATQDTTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self BuildViews];
    }
    return self;
}

-(void)BuildViews{
    //头像
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.image = [UIImage imageNamed:@"1"];
    [self.contentView addSubview:headImageView];
    self.headImageView = headImageView;
    
    //所属地方
    UILabel *addrLab = [[UILabel alloc] initWithFrame:CGRectZero];
    addrLab.text = @"上海";
    addrLab.font = [UIFont systemFontOfSize:14];
    addrLab.textColor = [UIColor colorWithHexString:UIColorStr];
    [self.contentView addSubview:addrLab];
    self.addrLabel = addrLab;
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"陈一发儿";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
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
    
    //头像图片
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.equalTo(nameLabel.mas_left).with.offset(-10);
    }];
    
    //位置
    [addrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(50,20));
        make.top.equalTo(headImageView.mas_bottom).offset(5);
    }];
    
    //名字
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(headImageView.mas_right).with.offset(10);
        
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.bottom.equalTo(msgLabel.mas_top).with.offset(-5);
    }];
    
    //动态信息
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(nameLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.height.offset(30);
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
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [chakanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.left.top.bottom.mas_equalTo(bottomView);
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
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = model.nick_name;
    self.msgLabel.text = model.desc;
    self.pinglunLabel.text = model.message_num;
    self.chakanLabel.text = [NSString stringWithFormat:@"%@人查看",model.read_num];
    self.huaLabel.text = model.flower_num;
    self.addrLabel.text = model.city;
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
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(msgHeight);
        }];
    }
    else
    {
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
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
    if([_delegate respondsToSelector:@selector(didClickedMoreBtn:indexPath:)])
    {
        [_delegate didClickedMoreBtn:sender indexPath:self.indexPath];
    }
}

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView{
    if([_delegate respondsToSelector:@selector(didClickImageViewWithCurrentCell:imageViewArray:imageSuperView:indexPath:)])
    {
        [_delegate didClickImageViewWithCurrentCell:imageView imageViewArray:array imageSuperView:superView indexPath:self.indexPath];
    }
}

-(void)huaClick{
    NSLog(@"hua---");
    if([self.delegate respondsToSelector:@selector(didClickHuaWithIndexPath:)])
    {
        [self.delegate didClickHuaWithIndexPath:self.indexPath];
    }
}
-(void)pinglunClick{
    NSLog(@"pinglun---");
    if([self.delegate respondsToSelector:@selector(didClickCommentWithIndexPath:)])
    {
        [self.delegate didClickCommentWithIndexPath:self.indexPath];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
