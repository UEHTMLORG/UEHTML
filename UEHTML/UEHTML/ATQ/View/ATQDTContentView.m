//
//  ATQDTContentView.m
//  UEHTML
//
//  Created by LHKH on 2017/11/4.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQDTContentView.h"
#import "ATQContentTableViewCell.h"
#import "ATQDTModel.h"
#import "ATQContentModel.h"
#import "MJExtension.h"
#import "NSString+ZJ.h"
@interface ATQDTContentView()<UITableViewDelegate,UITableViewDataSource>
{
    float CellHeight;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)NSMutableArray *heightArr;
@end

@implementation ATQDTContentView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _heightArr = [NSMutableArray array];
        [self setTableView];
    }
    return self;
}
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[ATQContentTableViewCell class] forCellReuseIdentifier:@"ATQContentTableViewCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
        tableView;
    });

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.bottom.mas_equalTo(self);
    }];
    
}
#pragma mark - Layout SubViews




#pragma mark - System Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentDataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ATQContentTableViewCell" ;
    ATQContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    ATQContentModel *model = nil;
    if (self.commentDataArray.count >0) {
        model = self.commentDataArray[indexPath.row];
    }
    [cell configCellWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ATQContentModel *model = nil;
    if (self.commentDataArray.count >0) {
        model = self.commentDataArray[indexPath.row];
    }
    float msgheight = [NSString stringHeightWithString:model.message size:12 maxWidth: ScreenWidth-80];
    CellHeight = msgheight +30;
    return CellHeight;
}
#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests




#pragma mark - Public Methods

- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.commentDataArray = [ATQContentModel mj_objectArrayWithKeyValuesArray:model.message_list];
    self.indexPath = indexPath;
    NSLog(@"%ld",self.commentDataArray.count);
    float height = 0;
    float msgheight = 0;
    for(ATQContentModel *commetmodel in self.commentDataArray)
    {
        ATQContentTableViewCell *cell = (ATQContentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
        msgheight = [NSString stringHeightWithString:commetmodel.message size:12 maxWidth: ScreenWidth-80];
        height += msgheight+30;
        [cell configCellWithModel:commetmodel];
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
    [self.tableView reloadData];
}


#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

