//
//  ATQSpreadMoenyViewController.m
//  UEHTML
//
//  Created by LHKH on 2017/9/27.
//  Copyright © 2017年 LHKH. All rights reserved.
//

#import "ATQSpreadMoenyViewController.h"
#import "QRCodeGenerator.h"
#import "UIColor+LhkhColor.h"
#import "LhkhHttpsManager.h"
#import "MBProgressHUD+Add.h"
@interface ATQSpreadMoenyViewController ()
@property (strong,nonatomic)NSArray *items;
@end

@implementation ATQSpreadMoenyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推广赚钱";
    _items = [NSArray array];
    [self loadData];
//    [self buildAttributeStr];
//    [self buildQRCodeView ];
//    [self buildPieChartView ];
    
}

-(void)viewDidLayoutSubviews{
    
}

-(void)loadData{
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID_AOTU_ZL];
    NSString *user_token = [[NSUserDefaults standardUserDefaults] objectForKey:USER_TOEKN_AOTU_ZL];
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
    NSString *url = [NSString stringWithFormat:@"%@/api/user/invite",ATQBaseUrl];
    
    [LhkhHttpsManager requestWithURLString:url parameters:params type:2 success:^(id responseObject) {
        NSLog(@"-----invite=%@",responseObject);
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            
            if (responseObject[@"data"]) {
                NSString *invite_code = responseObject[@"data"][@"invite_code"];
                self.tuijianLab.text = [NSString stringWithFormat:@"您的推荐码是 %@",invite_code];
                NSString *all_level_num = responseObject[@"data"][@"all_level_num"];
                self.tuijianRSLab.text = [NSString stringWithFormat:@"您一共推荐了%@人",all_level_num];
                
                NSString *level1_per = responseObject[@"data"][@"level1_per"];
                NSString *level2_per = responseObject[@"data"][@"level2_per"];
                NSString *level3_per = responseObject[@"data"][@"level3_per"];
                _items =  @[[PNPieChartDataItem dataItemWithValue:level1_per.integerValue color:[UIColor colorWithHexString:ChartColorStr1]],
                  [PNPieChartDataItem dataItemWithValue:level2_per.integerValue color:[UIColor colorWithHexString:ChartColorStr2] ],
                  [PNPieChartDataItem dataItemWithValue:level3_per.integerValue color:[UIColor colorWithHexString:ChartColorStr3] ],
                  ];
                [self buildAttributeStr];
                [self buildQRCodeView ];
                [self buildPieChartView];
            }
        }else if ([responseObject[@"status"] isEqualToString:@"302"]){
            
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

-(void)buildAttributeStr{
    NSScanner *scanner1 = [NSScanner scannerWithString:self.tuijianLab.text];
    [scanner1 scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner1 scanInt:&number];
    NSString *num=[NSString stringWithFormat:@"%d",number];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:self.tuijianLab.text];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIDeepTextColorStr] range:NSMakeRange(self.tuijianLab.text.length - num.length, num.length)];
    self.tuijianLab.attributedText = str1;
    
    
    NSScanner *scanner2 = [NSScanner scannerWithString:self.tuijianRSLab.text];
    [scanner2 scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number2;
    [scanner2 scanInt:&number2];
    NSString *num2=[NSString stringWithFormat:@"%d",number2];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:self.tuijianRSLab.text];
    [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:UIColorStr] range:NSMakeRange(self.tuijianRSLab.text.length - num2.length-1, num2.length)];
    self.tuijianRSLab.attributedText = str2;
}

-(void)buildQRCodeView{
    
    self.qrCodeImg.image = [QRCodeGenerator qrImageForString:@"http://www.matrojp.com/?m=webview&s=download" imageSize:self.qrCodeImg.bounds.size.width];
}
-(void)buildPieChartView{
//    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:15 color:[UIColor colorWithHexString:ChartColorStr1]],
//                       [PNPieChartDataItem dataItemWithValue:65 color:[UIColor colorWithHexString:ChartColorStr2] ],
//                       [PNPieChartDataItem dataItemWithValue:20 color:[UIColor colorWithHexString:ChartColorStr3] ],
//                       ];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, self.pieChatView.bounds.size.width, self.pieChatView.bounds.size.height) items:_items];
    self.pieChart.descriptionTextColor = [UIColor whiteColor];
    self.pieChart.descriptionTextFont = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;
    
    [self.pieChart strokeChart];
    
    
//    self.pieChart.legendStyle = PNLegendItemStyleStacked;
//    self.pieChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
//    
//    UIView *legend = [self.pieChart getLegendWithMaxWidth:200];
//    [legend setFrame:CGRectMake(130, 350, legend.frame.size.width, legend.frame.size.height)];
//    [self.view addSubview:legend];
    
    [self.pieChatView addSubview:self.pieChart];
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
