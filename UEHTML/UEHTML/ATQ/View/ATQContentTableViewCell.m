//
//  ATQContentTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQContentTableViewCell.h"
#import "MLLinkLabel.h"
#import "UIColor+LhkhColor.h"
#import "ATQContentModel.h"
#import "UIImageView+WebCache.h"
@interface ATQContentTableViewCell ()<MLLinkLabelDelegate>
@property (nonatomic, strong) MLLinkLabel *contentLabel;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *qiaoLabel;
@end

@implementation ATQContentTableViewCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self BuildViews];
    }
    return self;
}

-(void)BuildViews{
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:headImg];
    self.headImg = headImg;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLab.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    nameLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLab];
    self.nameLabel = nameLab;
    
    UILabel *qiaoLab = [[UILabel alloc] initWithFrame:CGRectZero];
    qiaoLab.text = @"悄悄话";
    qiaoLab.textColor = [UIColor colorWithHexString:UIColorStr];
    qiaoLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:qiaoLab];
    self.qiaoLabel = qiaoLab;
    
    self.contentLabel = [[MLLinkLabel alloc] init];
    self.contentLabel.delegate = self;
    self.contentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:92/255.0 green:140/255.0 blue:255/255.0 alpha:1.0]};
    self.contentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:92/255.0 green:140/255.0 blue:255/255.0 alpha:1]};
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:12];
    self.contentLabel.preferredMaxLayoutWidth = ScreenWidth-80;;
    [self.contentView addSubview:self.contentLabel];

    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.left.top.mas_equalTo(self.contentView);
    }];
    
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImg.mas_right).offset(5);
        make.top.mas_equalTo(headImg.mas_top);
        make.height.offset(15);
    }];
    
    [qiaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(nameLab.mas_centerY);
        make.height.offset(15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_left);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(nameLab.mas_bottom);
    }];
}

- (void)configCellWithModel:(ATQContentModel *)model
{
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"1"]];
    if ([model.model isEqualToString:@"1"]) {
        self.qiaoLabel.hidden = NO;
    }else{
        self.qiaoLabel.hidden = YES;
    }
    NSString *str = nil;
    if (![model.reply_user_id isEqualToString:@"0"]) {
        self.nameLabel.text = model.reply_nick_name;
        NSString *nickname = model.nick_name;
        str = [NSString stringWithFormat:@"回复%@:%@",nickname,model.message];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        [text setAttributes:@{NSLinkAttributeName : model.reply_nick_name} range:[str rangeOfString:model.nick_name]];
        self.contentLabel.attributedText = text;
    }else{
        self.nameLabel.text = model.nick_name;
        self.contentLabel.text = model.message;
    }
}

#pragma mark - Layout SubViews




#pragma mark - System Delegate




#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests




#pragma mark - Public Methods




#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

