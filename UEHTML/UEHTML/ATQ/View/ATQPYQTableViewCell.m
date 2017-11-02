//
//  ATQPYQTableViewCell.m
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPYQTableViewCell.h"
#import "ATQPYQModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ATQContainView.h"
#import "ATQCommentView.h"
#import "ATQOperationView.h"
#import "NSString+ZJ.h"
#import "UIColor+LhkhColor.h"
@interface ATQPYQTableViewCell ()<ATQContainViewDelegate,ATQCommentViewDelegate>
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *addrLabel;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *msgLabel;
@property (nonatomic,strong)UILabel *chakanLabel;
@property (nonatomic,strong)UILabel *pinglunLabel;
@property (nonatomic,strong)UILabel *huaLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic,strong)ATQContainView *imageViewContainView;//图片所在的view
@property (nonatomic,strong)UIButton *operationBtn;

@property (nonatomic,strong)UILabel *praiseLabel;//赞 label
@property (nonatomic,strong)ATQCommentView *commentView; // 评论view
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic,strong)ATQPYQModel *model;
@end
NSString *const ZJFriendLineCellOperationButtonClickedNotification = @"ZJFriendLineCellOperationButtonClickedNotification";
@implementation ATQPYQTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setup
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:ZJFriendLineCellOperationButtonClickedNotification object:nil];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:headImageView];
    self.headImageView = headImageView;
    
    UILabel *addrLab = [[UILabel alloc] initWithFrame:CGRectZero];
    addrLab.text = @"上海";
    addrLab.font = [UIFont systemFontOfSize:14];
    addrLab.textColor = [UIColor colorWithHexString:UIColorStr];
    [self.contentView addSubview:addrLab];
    self.addrLabel = addrLab;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textColor = [UIColor colorWithHexString:UIDeepTextColorStr];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.font = [UIFont systemFontOfSize:14];
    msgLabel.textColor = [UIColor colorWithHexString:UIDTTextColorStr];
    msgLabel.numberOfLines = 0;
    [self.contentView addSubview:msgLabel];
    self.msgLabel = msgLabel;
    
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
    ATQContainView *containView = [[ATQContainView alloc] init];
    containView.delegate = self;
    [self.contentView addSubview:containView];
    self.imageViewContainView = containView;
   
    ATQCommentView *comView = [[ATQCommentView alloc] init];
    comView.delegate = self;
    comView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:comView];
    self.commentView = comView;
    
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
    //头像图片
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).with.offset(10);
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
    //文字信息
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(nameLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    msgLabel.preferredMaxLayoutWidth = ScreenWidth-80;
    //更多按钮
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(msgLabel);
    }];
    
    //图片
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreBtn.mas_bottom).with.offset(10);
        make.left.mas_equalTo(moreBtn);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(20);
        make.left.right.mas_equalTo(self.msgLabel);
        make.top.mas_equalTo(containView.mas_bottom).offset(10);
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
    
    //赞 评论的View
    [comView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomView.mas_bottom).offset(5);
        make.left.right.mas_equalTo(self.msgLabel);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        
    }];
    
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.right.bottom.mas_equalTo(self);
    }];
//    self.hyb_lastViewInCell = comView;
//    self.hyb_bottomOffsetToCell = 10;
    
}


-(void)huaClick{
    NSLog(@"hua---");
    if([self.delegate respondsToSelector:@selector(didClickenLikeBtnWithIndexPath:)])
    {
        [self.delegate didClickenLikeBtnWithIndexPath:self.indexPath];
    }
}
-(void)pinglunClick{
    NSLog(@"pinglun---");
    if([self.delegate respondsToSelector:@selector(didClickCommentBtnWithIndexPath:)])
    {
        [self.delegate didClickCommentBtnWithIndexPath:self.indexPath];
    }
}
- (void)configCellWithModel:(ATQPYQModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.model = model;
    self.indexPath = indexPath;
    self.headImageView.image = [UIImage imageNamed:model.headImgName];
    self.nameLabel.text = model.usernName;
    self.msgLabel.text = model.msgContent;
    // self.imageViewContainView.model = model;
    float msgHeight = [NSString stringHeightWithString:model.msgContent size:15 maxWidth: ScreenWidth-80];
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
    if(model.picNameArray.count==0)
    {
        imageContainViewSize = CGSizeMake(0, 0);
    }
    else if (model.picNameArray.count>0 && model.picNameArray.count<4)
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80, (ScreenWidth-80-10)/3);
    }
    else
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80,(2*(ScreenWidth-90)/3)+5);
    }
    [self.imageViewContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreBtn.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.moreBtn);
        make.size.mas_equalTo(imageContainViewSize);
    }];
    
    self.imageViewContainView.model = model;
    [self.commentView configCellWithModel:model indexPath:indexPath];
}

-(void)moreAction:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(didClickedMoreBtn:indexPath:)])
    {
        [_delegate didClickedMoreBtn:sender indexPath:self.indexPath];
    }
}
-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView
{
    if([_delegate respondsToSelector:@selector(didClickImageViewWithCurrentView:imageViewArray:imageSuperView:indexPath:)])
    {
        [_delegate didClickImageViewWithCurrentView:imageView imageViewArray:array imageSuperView:superView indexPath:self.indexPath];
    }
}
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)])
    {
        [_delegate didClickRowWithFirstIndexPath:firIndexPath secondIndex:secIndexPath];
    }
}
-(void)operationBtnClick
{
    
    if(self.model.isLiked)
    {
        self.operationView.praiseString = @"取消赞";
    }
    else
    {
        self.operationView.praiseString = @"赞";
    }
    self.operationView.isShowing = !self.operationView.isShowing;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.operationView.isShowing = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZJFriendLineCellOperationButtonClickedNotification object:self.operationBtn];
}
- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{
    UIButton *btn = notification.object;
    if(btn != self.operationBtn && self.operationView.isShowing == YES)
    {
        self.operationView.isShowing = NO;
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
