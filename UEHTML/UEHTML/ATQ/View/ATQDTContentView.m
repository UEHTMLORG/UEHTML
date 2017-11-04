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
@interface ATQDTContentView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation ATQDTContentView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
    return 1;
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
    return 40;
}
#pragma mark - Custom Delegate




#pragma mark - Event Response




#pragma mark - Network requests




#pragma mark - Public Methods

- (void)configCellWithModel:(ATQDTModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.commentDataArray = [ATQContentModel mj_objectArrayWithKeyValuesArray:model.message_list];
    self.indexPath = indexPath;
    [self.tableView reloadData];
    float height;
    
    for(ATQContentModel *model in self.commentDataArray)
    {
//        float cellHeight = [ATQContentTableViewCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            ATQContentTableViewCell *cell = (ATQContentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell configCellWithModel:model];
//        }];
//        height += cellHeight;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
}


#pragma mark - Private Methods




#pragma mark - Getters and Setters



@end

