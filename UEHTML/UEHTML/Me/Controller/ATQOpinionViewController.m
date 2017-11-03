//
//  ATQOpinionViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQOpinionViewController.h"
#import "ATQQuesTableViewCell.h"
#import "ATQSZSecTableViewCell.h"
#import "ATQOpinionTableViewCell.h"
#import "ATQOpinionPhotoTableViewCell.h"
#import "ATQSZLoginOutTableViewCell.h"
#import "Masonry.h"
#import "UIColor+LhkhColor.h"
#import "KZPhotoManager.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQOpinionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL selectQues;
    NSString *questionStr;
    NSString *opinionStr;
    NSString *imgStr;
    NSInteger height;
}
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ATQOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    height = 140;
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        
        [tableView registerNib:[UINib nibWithNibName:@"ATQQuesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQQuesTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZSecTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQOpinionTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQOpinionTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQOpinionPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQOpinionPhotoTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZLoginOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZLoginOutTableViewCell"];
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
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (selectQues) {
            return 6;
        }else{
            return 1;
        }
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakself = self;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"ATQQuesTableViewCell" ;
            ATQQuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.quesLab.text = questionStr;
            cell.questionlistblock = ^{
                NSLog(@"----");
                selectQues = !selectQues;
                [self.tableView reloadData];
            };
            
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
            ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (indexPath.row == 1) {
                cell.titleLab.text = @"产品Bug提交";
            }else if (indexPath.row == 2){
                cell.titleLab.text = @"认证和技能审核相关";
            }else if (indexPath.row == 3){
                cell.titleLab.text = @"提现相关";
            }else if (indexPath.row == 4){
                cell.titleLab.text = @"账号封禁申诉";
            }else{
                cell.titleLab.text = @"产品优化建议";
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if (indexPath.section ==1){
        static NSString *CellIdentifier = @"ATQOpinionTableViewCell" ;
        ATQOpinionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        opinionStr = cell.opinionTextView.text;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQOpinionPhotoTableViewCell" ;
        ATQOpinionPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.xuanZeTuPianBlock = ^(){//选择图片
            [KZPhotoManager getImage:^(UIImage *image) {
                ATQOpinionPhotoTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
                [cell.imgsArray insertObject:image atIndex:0];
                [weakself uploadImage:image];
                [cell.photoCollectionView reloadData];
                CGFloat width = (ScreenWidth - 55)/4;
                if (cell.imgsArray.count >0 && cell.imgsArray.count <= 4) {
                    height = 140;
                }else if (cell.imgsArray.count >4 && cell.imgsArray.count <= 8){
                    height = 140 + width + 20;
                }else if((cell.imgsArray.count-1) >8 && (cell.imgsArray.count-1) <= 12){
                    height = 140 + 2*width + 30;
                }else{
                    height = 140 + 3*width + 40;
                }
                [weakself.tableView reloadData];
            } showIn:weakself AndActionTitle:@"请选择照片"];
            
        };
        cell.deleteSCTuPianBlock = ^{
             ATQOpinionPhotoTableViewCell *cell  =[weakself.tableView cellForRowAtIndexPath:indexPath];
            CGFloat width = (ScreenWidth - 55)/4;
            if ((cell.imgsArray.count-1)>0 && (cell.imgsArray.count-1) <= 4) {
                height = 140;
            }else if ((cell.imgsArray.count-1) >4 && (cell.imgsArray.count-1) <= 8){
                height = 140 + width + 20;
            }else if((cell.imgsArray.count-1) >8 && (cell.imgsArray.count-1) <= 12){
                height = 140 + 2*width + 30;
            }else{
                height = 140 + 3*width + 40;
            }
            [weakself.tableView reloadData];
        };
        return cell;
    }else{
        static NSString *CellIdentifier = @"ATQSZLoginOutTableViewCell" ;
        ATQSZLoginOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.loginOutBtn setTitle:@"提交" forState:UIControlStateNormal];
        cell.loginoutblock = ^{
            NSLog(@"提交");
            [weakself commitOpoion];
        };
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row != 0) {
            ATQSZSecTableViewCell *cell = (ATQSZSecTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
            questionStr = cell.titleLab.text;
            selectQues = NO;
            [self.tableView reloadData];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 40;
    }else if (indexPath.section == 1){
        return 150;
    }else if (indexPath.section == 2){
        return height;
    }else{
        return 80;
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 3) {
        
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        view.backgroundColor = [UIColor colorWithHexString:UIBgColorStr];
        return view;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 3) {
        return 0;
    }else{
        return 10;
    }
}

-(void)commitOpoion{
    NSLog(@"--%@--%@--%@",questionStr,opinionStr,imgStr);
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"model"] = questionStr;
    params[@"content"] = opinionStr;
    params[@"pictures"] = imgStr;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/suggest",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----suggest=%@",responseObject);
       
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            if(responseObject[@"data"] ){
                [MBProgressHUD show:responseObject[@"message"] view:self.view];
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        } else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)uploadImage:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    NSString *picStr = [data base64EncodedStringWithOptions:0];
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"picture_type"] = @"suggest";
    params[@"picture"] = picStr;
    params[@"user_id"] = user_id;
    params[@"user_token"] = user_token;
    params[@"apptype"] = @"ios";
    params[@"appversion"] = APPVERSION_AOTU_ZL;
    NSString *random_str = [LhkhHttpsManager getNowTimeTimestamp];
    params[@"random_str"] = random_str;
    NSString *app_token = APP_TOKEN;
    NSString *signStr = [NSString stringWithFormat:@"%@%@",app_token,random_str];
    NSString *sign1 = [LhkhHttpsManager md5:signStr];
    NSString *sign2 = [LhkhHttpsManager md5:sign1];
    NSString *sign = [LhkhHttpsManager md5:sign2];
    params[@"sign"] = sign;
    NSString *url = [NSString stringWithFormat:@"%@/api/user/upload_picture",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----upload_picture=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                NSString *imageStr = responseObject[@"data"];
                if (imgStr == nil) {
                    imgStr = [NSString stringWithFormat:@"%@",imageStr];
                }else{
                    imgStr = [NSString stringWithFormat:@"%@,%@",imgStr,imageStr];
                }
                NSLog(@"---->%@",imgStr);
            }
            
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self login];
            });
        }else{
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
