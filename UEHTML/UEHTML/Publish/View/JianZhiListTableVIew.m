//
//  JianZhiListTableVIew.m
//  UEHTML
//
//  Created by apple on 2017/10/11.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "JianZhiListTableVIew.h"

@implementation JianZhiListTableVIew

- (instancetype)init{

    self = [super init];
    if (self) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
        
        [self addSubview:self.tableview];
        [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)loadTableViewWith:(NSMutableArray *)arrary withCellType:(JianZhiCenterCellType)type{
    self.currentCellType = type;
    [self.tableview registerNib:[UINib nibWithNibName:@"JianZhiTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JianZhiYiCellID"];
     [self.tableview registerNib:[UINib nibWithNibName:@"TiGongTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TiGongCellID"];
}

- (void)reloadTableViewWith:(NSMutableArray *)arrary withCellType:(JianZhiCenterCellType)type{
}

#pragma mark ===================TableviewDelegate==================
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.currentCellType) {
        case JIANZHICELLTYPE:
            return 92.0f;
            break;
        case TIGONGCELLTYPE:
            return 112.0f;
            break;
        default:
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.currentCellType) {
        case JIANZHICELLTYPE:{
            static NSString *rid=@"JianZhiYiCellID";
            JianZhiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            
            
            
            return cell;
        }
            break;
        case TIGONGCELLTYPE:{
            static NSString *rid=@"TiGongCellID";
            TiGongTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            
            
            
            return cell;
        }
            break;
        default:
            
            break;
    }
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了Cell");
}


- (NSMutableArray *)tableARR{
    if (!_tableARR) {
        _tableARR = [NSMutableArray new];
    }
    return _tableARR;
}

@end
