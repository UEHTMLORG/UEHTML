//
//  ATQSCMyAlumbViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/19.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSCMyAlumbViewController.h"
#import "ATQAddImgCollectionViewCell.h"
#import "UIColor+LhkhColor.h"
#import "KZPhotoManager.h"
#import "ATQMyAlumbSCFTableViewCell.h"
#import "ATQMyAlumbSCSTableViewCell.h"
#import "ATQMyAlumbSCTTableViewCell.h"
@interface ATQSCMyAlumbViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger height;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ATQSCMyAlumbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的相册";
     height = 180;
    [self setTableView];
}
-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMyAlumbSCFTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMyAlumbSCFTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQMyAlumbSCSTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMyAlumbSCSTableViewCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQMyAlumbSCTTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQMyAlumbSCTTableViewCell"];
        
        tableView.backgroundColor = RGBA(236, 236, 236, 1);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        tableView;
    });
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(0);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if(indexPath.section == 0){
        static NSString *CellIdentifier = @"ATQMyAlumbSCFTableViewCell" ;
        ATQMyAlumbSCFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"ATQMyAlumbSCSTableViewCell" ;
        ATQMyAlumbSCSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQMyAlumbSCTTableViewCell" ;
        ATQMyAlumbSCTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shangchuanTuPianBlock = ^{
            [KZPhotoManager getImage:^(UIImage *image) {
                ATQMyAlumbSCTTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                [cell.imgsArray insertObject:image atIndex:0];
                [cell.photoCollectionView reloadData];
                CGFloat width = (ScreenWidth - 55)/4;
                if (cell.imgsArray.count >0 && cell.imgsArray.count <= 4) {
                    height = 180;
                }else if (cell.imgsArray.count >4 && cell.imgsArray.count <= 8){
                    height = 180 + width + 20;
                }else if((cell.imgsArray.count-1) >8 && (cell.imgsArray.count-1) <= 12){
                    height = 180 + 2*width + 30;
                }else{
                    height = 180 + 3*width + 40;
                }
                [weakself.tableView reloadData];
            } showIn:weakself AndActionTitle:@"请选择照片"];
        };
        cell.deleteSCTuPianBlock = ^{
            
            ATQMyAlumbSCTTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
            CGFloat width = (ScreenWidth - 55)/4;
            if ((cell.imgsArray.count-1)>0 && (cell.imgsArray.count-1) <= 4) {
                height = 180;
            }else if ((cell.imgsArray.count-1) >4 && (cell.imgsArray.count-1) <= 8){
                height = 180 + width + 20;
            }else if((cell.imgsArray.count-1) >8 && (cell.imgsArray.count-1) <= 12){
                height = 180 + 2*width + 30;
            }else{
                height = 180 + 3*width + 40;
            }
            [weakself.tableView reloadData];
        };
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        return 80;
        
    }else{
        return height;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }else{
        return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }else{
        return 0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
