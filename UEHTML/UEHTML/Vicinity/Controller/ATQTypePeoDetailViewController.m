//
//  ATQTypePeoDetailViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/10/2.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQTypePeoDetailViewController.h"
#import "ATQYajinRZViewController.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
#import "UIImageView+WebCache.h"
@interface ATQTypePeoDetailViewController ()<UITextViewDelegate,CPStepperDelegate>{
    UIControl *_blackView;
    NSDictionary *job;
    NSDictionary *user_profile;
    
}
@property (nonatomic,strong)UIView *datePickerView;
@property (nonatomic,strong)UIDatePicker *datePicker;
@end

@implementation ATQTypePeoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"下单约TA";
    self.textField.stepperDelegate = self;
    [self buildTextView];
    [self setblackView];
    [self setDatePickerView];
    [self loadData];
}

-(void)loadData{
    
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
    params[@"job_id"] = self.jobID;
    params[@"page_index"] = @"1";
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
    NSString *url = [NSString stringWithFormat:@"%@/api/job/place_order/work_about_her",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {

        NSLog(@"-----work_about_her=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            if(responseObject[@"data"]){
                user_profile = responseObject[@"data"][@"user_profile"];
                job = responseObject[@"data"][@"job"];
                [self.userImg sd_setImageWithURL:[NSURL URLWithString:user_profile[@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];
                self.userNameLab.text = user_profile[@"nick_name"];
                self.chengLab.text = user_profile[@"credit_num"];
                self.ageLab.text = user_profile[@"age"];
                if ([user_profile[@"gender"] isEqualToString:@"1"]) {
                    self.sexImg.image = [UIImage imageNamed:@"jianzhi-button-nan02"];
                }else{
                    self.sexImg.image = [UIImage imageNamed:@"fujin-nv03"];
                }
                self.disLab.text = responseObject[@"data"][@"distance"];
             
                self.tagLab.text = [NSString stringWithFormat:@"%@cm %@kg",user_profile[@"height"],user_profile[@"weight"]];
                if ([user_profile[@"deposit_auth"] isEqualToString:@"0"]) {
                    self.rzImg.hidden = YES;
                }else{
                    self.rzImg.hidden = NO;
                }
                
                if ([user_profile[@"card_level"] isEqualToString:@"0"]) {
                    self.vipImg.hidden = YES;
                }else{
                    self.vipImg.hidden = NO;
                }
                NSString *price = job[@"price"];
                self.jiageLab.text = [NSString stringWithFormat:@"线下服务 %.f元/小时",price.floatValue];
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

-(void)buildTextView{
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = RGBA(241, 241, 241, 1).CGColor;
    self.textView.layer.cornerRadius = 5.f;
    self.textView.placeholder = @"可以具体描述身体不适的情况，对足疗师的要求和期望达到的效果等";
    self.textView.placeholderFont = [UIFont systemFontOfSize:6];
    self.textView.delegate = self;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"押金认证"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr]  range:strRange];
    [str addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:strRange];
    
    [self.yajinBtn setAttributedTitle:str forState:UIControlStateNormal];
}

-(void)setblackView{
    _blackView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight -  260)];
    [_blackView addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.4;
    _blackView.hidden = YES;
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:_blackView];
    
}

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
        make.height.mas_equalTo(260);
    }];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_datePickerView).offset(0);
        make.height.mas_equalTo(216);
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
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.maximumDate = maxDate;
    
}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    NSLog(@"dateChanged响应事件：%@",date);
    NSDate *pickerDate = [self.datePicker date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    NSLog(@"格式化显示时间：%@",dateString);
    self.yuyueTimeLab.text = dateString;
}

-(void)cancelButtonAction:(id)sender{
    
    _blackView.hidden = _datePickerView.hidden = YES;
}

-(void)sureButtonAction:(id)sender{
    
    _blackView.hidden = _datePickerView.hidden = YES;
}
- (IBAction)timeClick:(id)sender {
    _blackView.hidden = _datePickerView.hidden = NO;
}

//押金认证
- (IBAction)yajinClick:(id)sender {
    ATQYajinRZViewController *vc = [[ATQYajinRZViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addField:(CPStepper *)field ButtonClick:(id)prolist count:(int)textCount{
    NSLog(@"----------%d",textCount);
    NSString *price = job[@"price"];
    
    self.shijineLab.text = [NSString stringWithFormat:@"共：%.f元",price.floatValue*textCount];
}

-(void)subButtonClicked:(NSDictionary *)param count:(int)textCount{
    NSLog(@"++++++++++%d",textCount);
    NSString *price = job[@"price"];
    self.shijineLab.text = [NSString stringWithFormat:@"共：%.f元",price.floatValue*textCount];
}
- (IBAction)anbaoClick:(id)sender {
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
