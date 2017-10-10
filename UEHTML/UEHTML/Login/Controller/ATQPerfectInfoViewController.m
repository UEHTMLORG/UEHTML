//
//  ATQPerfectInfoViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/20.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQPerfectInfoViewController.h"
#import "AppDelegate.h"
#import "UIColor+LhkhColor.h"
#import "Masonry.h"
#import "ATQRenzhengViewController.h"
@interface ATQPerfectInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>{
    UIControl *_blackView;
    NSString *dateStr;
}
@property (nonatomic,strong)UIView *datePickerView;
@property (nonatomic,strong)UIDatePicker *datePicker;
@end

@implementation ATQPerfectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"完善资料";
    [self buildView];
    [self setblackView];
    [self setDatePickerView];
}

-(void)buildView{
    
    self.nickView.layer.masksToBounds = YES;
    self.nickView.layer.cornerRadius = 4.f;
    self.nickView.layer.borderWidth = 1.f;
    self.nickView.layer.borderColor = [UIColor colorWithHexString:UIToneTextColorStr].CGColor;
    
    self.sexView.layer.masksToBounds = YES;
    self.sexView.layer.cornerRadius = 4.f;
    self.sexView.layer.borderWidth = 1.f;
    self.sexView.layer.borderColor = [UIColor colorWithHexString:UIToneTextColorStr].CGColor;
    
    self.ageView.layer.masksToBounds = YES;
    self.ageView.layer.cornerRadius = 4.f;
    self.ageView.layer.borderWidth = 1.f;
    self.ageView.layer.borderColor = [UIColor colorWithHexString:UIToneTextColorStr].CGColor;
    
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 4.f;
}

//头像
- (IBAction)headClick:(id)sender {
    NSLog(@"点击了图像");
    [self selectImage];
}

//男
- (IBAction)manClick:(id)sender {
    self.manBtn.selected = YES;
    self.womanBtn.selected = !self.manBtn.selected;
}
//女
- (IBAction)womanClick:(id)sender {
    self.womanBtn.selected = YES;
    self.manBtn.selected = !self.womanBtn.selected;
}
//年龄
- (IBAction)ageClick:(id)sender {
    
    _blackView.hidden = _datePickerView.hidden = NO;
    
}
//下一步
- (IBAction)nextClick:(id)sender {
    ATQRenzhengViewController *vc = [[ATQRenzhengViewController alloc]init];
//    [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)setblackView{
    _blackView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  210)];
    [_blackView addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.4;
    _blackView.hidden = YES;
    
    [self.view addSubview:_blackView];
    
}

//更换头像
-(void)selectImage{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册上传" otherButtonTitles:@"拍照上传", nil];
    [sheet showInView:self.view];
}

//选择日期
-(void)setDatePickerView{
    
    _datePickerView = [[UIView alloc]initWithFrame:CGRectZero];
    _datePickerView.backgroundColor = [UIColor whiteColor];
    _datePickerView.hidden = YES;
    [self.view addSubview:_datePickerView];
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    cancelBtn.layer.cornerRadius = 4.f;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    [cancelBtn addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    sureBtn.layer.cornerRadius = 4.f;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.backgroundColor = [UIColor colorWithHexString:UIColorStr];
    [sureBtn addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_datePickerView addSubview:cancelBtn];
    [_datePickerView addSubview:sureBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_datePickerView).offset(15);
        make.top.mas_equalTo(_datePickerView).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_datePickerView).offset(-15);
        make.top.mas_equalTo(_datePickerView).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
    self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_datePickerView addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    //设置显示格式
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.datePicker.locale = locale;
    [_datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view).offset(0);
        make.height.mas_equalTo(210);
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_datePickerView).offset(0);
        make.height.mas_equalTo(166);
    }];
    
    
    //当前时间创建NSDate
    NSDate *localDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //设置时间
    [offsetComponents setYear:0];
    [offsetComponents setMonth:0];
    [offsetComponents setDay:0];
    NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = maxDate;
    
}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    NSLog(@"dateChanged响应事件：%@",date);
    NSDate *pickerDate = [self.datePicker date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    NSLog(@"格式化显示时间：%@",dateString);
    dateStr = dateString;
    
}

-(void)cancelButtonAction:(id)sender{
    
    _blackView.hidden = _datePickerView.hidden = YES;
}

-(void)sureButtonAction:(id)sender{
    
    _blackView.hidden = _datePickerView.hidden = YES;
    self.ageLab.text = dateStr;
    
}

#pragma UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
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
}

#pragma UIImagePickerController delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.headImg.image = image;
//    NSData *data = UIImageJPEGRepresentation(image, 0.3);
//    NSString *picStr = [data base64EncodedStringWithOptions:0];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
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
