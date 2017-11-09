//
//  ATQUserInfoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQUserInfoViewController.h"
#import "ATQSZUserHeaderCell.h"
#import "ATQSZSecTableViewCell.h"
#import "ATQSZFourTableViewCell.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "ATQFaceRZViewController.h"
#import "MBProgressHUD+Add.h"
#import "ATQRZCenterViewController.h"
#import "ATQYajinRZViewController.h"
#import "ATQSPRZViewController.h"
#import "ATQModifyUserInfoViewController.h"
#import "ATQModifyZhanghaoViewController.h"
@interface ATQUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,FaceRZIsSuccessDelegate,modifyPasszhanghuDelegate,modifyPassValueDelegate>{
    BOOL isHeader;
    NSString *sexstr;
    NSString *nicheng;
    NSString *avatarstr;
    NSString *zhanghu;
    NSString *shengao;
    NSString *tizhong;
    NSString *nianling;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ATQUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"用户信息";
    self.view.backgroundColor = [UIColor whiteColor];
    avatarstr = _dic[@"avatar"];
    nicheng = _dic[@"nick_name"];
    zhanghu = @"123121241";
    shengao = @"165cm";
    tizhong = @"45kg";
    nianling = @"22岁";
    [self setTableView];
}

-(void)setTableView{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZUserHeaderCell" bundle:nil] forCellReuseIdentifier:@"ATQSZUserHeaderCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZSecTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZSecTableViewCell"];
        [tableView registerNib:[UINib nibWithNibName:@"ATQSZFourTableViewCell" bundle:nil] forCellReuseIdentifier:@"ATQSZFourTableViewCell"];
        
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
        return 3;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else {
        return 4;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"ATQSZUserHeaderCell" ;
            ATQSZUserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            if (avatarstr !=nil) {
                [cell.userImg sd_setImageWithURL:[NSURL URLWithString:avatarstr] placeholderImage:[UIImage imageNamed:@""]];
            }else{
                cell.userImg.image = [UIImage imageNamed:@""];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQSZFourTableViewCell" ;
            ATQSZFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.titleLab.text = @"我的昵称";
                cell.cacheLab.text = nicheng;
            }else{
                cell.titleLab.text = @"账号安全";
                cell.cacheLab.text = zhanghu;
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
            ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = @"我的认证";
            return cell;
        }else{
            static NSString *CellIdentifier = @"ATQSZFourTableViewCell" ;
            ATQSZFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
                cell = [array objectAtIndex:0];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.titleLab.text = @"会员等级";
                cell.cacheLab.text = @"普通会员";
            }else{
                cell.titleLab.text = @"押金认证";
                cell.cacheLab.text = @"贫农";
            }
            return cell;
        }
    }else if (indexPath.section == 2){
        static NSString *CellIdentifier = @"ATQSZSecTableViewCell" ;
        ATQSZSecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = @"视频认证";
        return cell;
    }else{
        
        static NSString *CellIdentifier = @"ATQSZFourTableViewCell" ;
        ATQSZFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle]loadNibNamed: CellIdentifier owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.titleLab.text = @"身高";
            cell.cacheLab.text = shengao;
        }else if(indexPath.row == 1){
            cell.titleLab.text = @"体重";
            cell.cacheLab.text = tizhong;
        }else if(indexPath.row == 2){
            cell.titleLab.text = @"年龄";
            cell.cacheLab.text = nianling;
        }else {
            cell.titleLab.text = @"性别";
            if ([sexstr isEqualToString:@"1"]) {
                cell.cacheLab.text = @"男";
            }else{
                cell.cacheLab.text = @"女";
            }
            
        }
        
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            ATQFaceRZViewController *vc = [[ATQFaceRZViewController alloc] init];
            vc.delegate = self;
            vc.vcStr = @"ATQSFRZViewController";
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1){
            NSLog(@"我的昵称");
            ATQModifyUserInfoViewController *vc = [[ATQModifyUserInfoViewController alloc] init];
            vc.natitle = @"我的昵称";
            vc.passStr = nicheng;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"账号安全");
            ATQModifyZhanghaoViewController *vc = [[ATQModifyZhanghaoViewController alloc] init];
            vc.natitle = @"账号安全";
            vc.passStr = zhanghu;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            NSLog(@"我的认证");
            ATQRZCenterViewController *vc = [[ATQRZCenterViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row ==1){
            NSLog(@"会员等级");
        }else{
            NSLog(@"押金认证");
            ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2){
        NSLog(@"视频认证");
        ATQSPRZViewController *vc = [[ATQSPRZViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        if (indexPath.row == 0) {
            NSLog(@"身高");
            ATQModifyUserInfoViewController *vc = [[ATQModifyUserInfoViewController alloc] init];
            vc.natitle = @"身高";
            vc.passStr = shengao;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            NSLog(@"体重");
            ATQModifyUserInfoViewController *vc = [[ATQModifyUserInfoViewController alloc] init];
            vc.natitle = @"体重";
            vc.passStr = tizhong;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            NSLog(@"年龄");
            ATQModifyUserInfoViewController *vc = [[ATQModifyUserInfoViewController alloc] init];
            vc.natitle = @"年龄";
            vc.passStr = nianling;
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            isHeader = NO;
            [self someButtonClicked];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        return [[UIView alloc]init];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

-(void)passValue:(NSString *)SusStr{
    if (SusStr !=nil && [SusStr isEqualToString:@"1"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isHeader = YES;
            [self someButtonClicked];
        });
    }
}
-(void)passmodifyValue:(NSString *)SusStr type:(NSString*)type{
    NSLog(@"---%@",SusStr);
    if ([type isEqualToString:@"我的昵称"]) {
        nicheng = SusStr;
    }else if ([type isEqualToString:@"身高"]){
        shengao = SusStr;
    }else if ([type isEqualToString:@"体重"]){
        tizhong = SusStr;
    }else if ([type isEqualToString:@"年龄"]){
        nianling = SusStr;
    }
    [self.tableView reloadData];
    
}
-(void)passzhanghuValue:(NSString *)SusStr{
    NSLog(@"---%@",SusStr);
    zhanghu = SusStr;
    [self.tableView reloadData];
}

#pragma mark 修改图片 昵称
- (void)someButtonClicked {
    UIActionSheet * sheet;
    if (isHeader == YES) {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册上传" otherButtonTitles:@"拍照上传", nil];
    }else{
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
    }
    
    [sheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"点击了第几个按钮result = %d", (int)buttonIndex);
    if (isHeader == YES) {
        NSInteger sourcetype = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 2:
                    return;
                    break;
                case 1:
                    sourcetype = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 0:
                    sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
        }else{
            if (buttonIndex == 2) {
                return;
            }else{
                sourcetype = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imggePickerVc = [[UIImagePickerController alloc]init];
        imggePickerVc.delegate = self;
        imggePickerVc.allowsEditing = YES;
        imggePickerVc.sourceType = sourcetype;
        [self presentViewController:imggePickerVc animated:NO completion:nil];
        
    }else{
        if (buttonIndex == 0) {
            sexstr = @"1";
        }else if (buttonIndex == 1){
            sexstr = @"2";
        }else{
            
        }
        [self.tableView reloadData];
    }
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    
    NSString *picStr = [data base64EncodedStringWithOptions:0];
    [self uploadImage:picStr];
    [picker dismissViewControllerAnimated:NO completion:nil];
}

-(void)uploadImage:(NSString *)imageStr{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"avatar"] = imageStr;
    params[@"avatar_auth"] = @"1";
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/upload_avatar",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----upload_picture=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [MBProgressHUD show:responseObject[@"message"] view:self.view];
            if (responseObject[@"data"]) {
                NSString *imgStr = responseObject[@"data"];
                avatarstr = imgStr;
                [self.tableView reloadData];
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
