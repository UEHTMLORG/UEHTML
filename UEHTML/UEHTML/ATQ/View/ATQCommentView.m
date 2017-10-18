//
//  ATQCommentView.m
//  UEHTML
//
//  Created by LHKH on 2017/10/14.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQCommentView.h"
#import "ATQPYQModel.h"
#import "ATQCommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MLLinkLabel.h"
#import "ATQCommentTableViewCell.h"
@interface ATQCommentView ()<UITableViewDelegate,UITableViewDataSource,MLLinkLabelDelegate>
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)UIImageView *bigImageView;
@property (nonatomic,strong)MLLinkLabel *praiseLabel;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation ATQCommentView

-(id)init
{
    if(self = [super init])
    {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;
        
        [self addSubview:tableView];
        self.tableView = tableView;

        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=  [ATQCommentTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        ATQCommentTableViewCell *cell = (ATQCommentTableViewCell *)sourceCell;
        [cell configCellWithModel:self.commentDataArray[indexPath.row]];
    } ];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATQCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATQCommentTableViewCell"];
    if(cell==nil)
    {
        cell = [[ATQCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATQCommentTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell configCellWithModel:self.commentDataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)])
    {
        [_delegate didClickRowWithFirstIndexPath:self.indexPath secondIndex:indexPath];
    }
}
- (void)configCellWithModel:(ATQPYQModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.commentDataArray = [NSMutableArray arrayWithArray:model.commentArray];
    self.likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    self.indexPath = indexPath;
    [self setPraiseLabelTextWithLikeArray:model.likeNameArray];
    [self.tableView reloadData];
    float height;
    for(ATQCommentModel *model in self.commentDataArray)
    {
        float cellHeight = [ATQCommentTableViewCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            ATQCommentTableViewCell *cell = (ATQCommentTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
        height += cellHeight;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
}
-(void)setPraiseLabelTextWithLikeArray:(NSArray *)array
{
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    for(int i=0;i<array.count;i++)
    {
        NSString *string = array[i];
        if(i>0)
        {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString setAttributes:@{ NSLinkAttributeName :string} range:[string rangeOfString:string]];
        [attributedText appendAttributedString:attString];
    }
    self.praiseLabel.attributedText = [attributedText copy];
}
- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel
{
    NSLog(@"点击了：%@",link.linkValue);
}

@end
