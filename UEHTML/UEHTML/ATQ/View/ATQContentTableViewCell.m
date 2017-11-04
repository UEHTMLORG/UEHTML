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
    headImg.image = [UIImage imageNamed:@"1"];
    [self.contentView addSubview:headImg];
    self.headImg = headImg;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLab.text = @"陈一发儿";
    nameLab.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    nameLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:nameLab];
    self.nameLabel = nameLab;
    
    self.contentLabel = [[MLLinkLabel alloc] init];
    self.contentLabel.text = @"恩，是很不错额";
    self.contentLabel.delegate = self;
    self.contentLabel.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:92/255.0 green:140/255.0 blue:255/255.0 alpha:1.0]};
    self.contentLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
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
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_left);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(nameLab.mas_bottom);
    }];
}

- (void)configCellWithModel:(ATQContentModel *)model
{
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"1"]];
    self.nameLabel.text = model.nick_name;
    self.contentLabel.text = model.message;
    
//    NSString *string =[NSString stringWithFormat:@"%@",model.content];
//    if(model.replyUserName.length != 0)
//    {
//        self.nameLabel.text = model.userName;
//        string =[NSString stringWithFormat:@"回复%@：%@",model.replyUserName ,model.content];
//    }
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
//    [text setAttributes:@{NSLinkAttributeName : model.userName} range:[string rangeOfString:model.userName]];
//    if(model.replyUserName.length != 0)
//    {
//        [text setAttributes:@{NSLinkAttributeName : model.replyUserName} range:[string rangeOfString:model.replyUserName]];
//    }
//    self.contentLabel.attributedText = text;
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

